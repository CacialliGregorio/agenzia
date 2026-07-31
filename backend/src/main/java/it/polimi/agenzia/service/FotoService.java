package it.polimi.agenzia.service;

import it.polimi.agenzia.entity.Foto;
import it.polimi.agenzia.entity.Immobile;
import it.polimi.agenzia.repository.FotoRepository;
import it.polimi.agenzia.repository.ImmobileRepository;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;

@Service
public class FotoService {

    /*
     * Cartella locale mantenuta solo per compatibilità con eventuali vecchie foto
     * salvate prima del passaggio a Cloudflare R2.
     */
    private final Path uploadRoot = Paths.get("uploads", "immobili");

    private static final int LARGHEZZA_MASSIMA = 1600;
    private static final int ALTEZZA_MASSIMA = 1600;
    private static final double QUALITA_JPG = 0.80;

    @Autowired
    private FotoRepository fotoRepository;

    @Autowired
    private ImmobileRepository immobileRepository;

    @Autowired
    private S3Client s3Client;

    @Value("${r2.bucket-name}")
    private String bucketName;

    @Value("${r2.public-url}")
    private String publicUrl;

    public List<String> caricaFoto(Long immobileId, List<MultipartFile> files, Long userId) {
        Immobile immobile = immobileRepository.findById(immobileId)
                .orElseThrow(() -> new RuntimeException("Immobile non trovato"));

        if (!immobile.getUser().getId().equals(userId)) {
            throw new RuntimeException("Non autorizzato a caricare foto per questo immobile");
        }

        if (files == null || files.isEmpty()) {
            throw new RuntimeException("Nessuna foto caricata");
        }

        List<String> percorsiSalvati = new ArrayList<>();

        try {
            List<Foto> fotoEsistenti =
                    fotoRepository.findByImmobileIdOrderByOrdinamentoAsc(immobileId);

            int ordinamento = fotoEsistenti.size();

            for (MultipartFile file : files) {
                if (file == null || file.isEmpty()) {
                    continue;
                }

                validaFileImmagine(file);

                String nomeFile = System.currentTimeMillis()
                        + "-"
                        + UUID.randomUUID()
                        + ".jpg";

                String objectKey = "immobili/" + immobileId + "/" + nomeFile;

                byte[] immagineCompressa = comprimiImmagine(file);

                caricaSuR2(objectKey, immagineCompressa);

                String percorsoPubblico = pulisciUrl(publicUrl) + "/" + objectKey;

                Foto foto = Foto.builder()
                        .immobile(immobile)
                        .nomeFile(objectKey)
                        .percorso(percorsoPubblico)
                        .ordinamento(ordinamento)
                        .build();

                fotoRepository.save(foto);

                percorsiSalvati.add(percorsoPubblico);
                ordinamento++;
            }

            return percorsiSalvati;

        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("Errore durante la compressione delle immagini");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Errore durante il caricamento delle immagini su Cloudflare R2");
        }
    }

    private void validaFileImmagine(MultipartFile file) {
        String contentType = file.getContentType();

        if (contentType == null || !contentType.startsWith("image/")) {
            throw new RuntimeException("Puoi caricare solo file immagine");
        }

        String nomeOriginale = file.getOriginalFilename();

        if (nomeOriginale == null || nomeOriginale.isBlank()) {
            throw new RuntimeException("Nome file immagine non valido");
        }

        String nomeMinuscolo = nomeOriginale.toLowerCase();

        boolean estensioneValida =
                nomeMinuscolo.endsWith(".jpg") ||
                        nomeMinuscolo.endsWith(".jpeg") ||
                        nomeMinuscolo.endsWith(".png") ||
                        nomeMinuscolo.endsWith(".webp");

        if (!estensioneValida) {
            throw new RuntimeException("Formato immagine non supportato. Usa JPG, JPEG, PNG o WEBP");
        }
    }

    private byte[] comprimiImmagine(MultipartFile file) throws IOException {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        Thumbnails.of(file.getInputStream())
                .size(LARGHEZZA_MASSIMA, ALTEZZA_MASSIMA)
                .outputFormat("jpg")
                .outputQuality(QUALITA_JPG)
                .toOutputStream(outputStream);

        return outputStream.toByteArray();
    }

    private void caricaSuR2(String objectKey, byte[] bytes) {
        PutObjectRequest request = PutObjectRequest.builder()
                .bucket(bucketName)
                .key(objectKey)
                .contentType("image/jpeg")
                .contentLength((long) bytes.length)
                .build();

        s3Client.putObject(request, RequestBody.fromBytes(bytes));

        System.out.println("Foto caricata su R2: " + objectKey);
    }

    public void eliminaFoto(Long immobileId, String percorso, Long userId) {
        Immobile immobile = immobileRepository.findById(immobileId)
                .orElseThrow(() -> new RuntimeException("Immobile non trovato"));

        if (!immobile.getUser().getId().equals(userId)) {
            throw new RuntimeException("Non autorizzato a eliminare foto per questo immobile");
        }

        List<Foto> fotoImmobile =
                fotoRepository.findByImmobileIdOrderByOrdinamentoAsc(immobileId);

        Foto fotoDaEliminare = fotoImmobile.stream()
                .filter(foto -> foto.getPercorso().equals(percorso))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Foto non trovata"));

        try {
            eliminaFileFoto(immobileId, fotoDaEliminare);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Errore durante l'eliminazione del file immagine");
        }

        fotoRepository.delete(fotoDaEliminare);

        riordinaFoto(immobileId);
    }

    /*
     * Metodo usato quando viene eliminato un intero annuncio.
     * Prima elimina tutte le immagini fisiche da Cloudflare R2 o dal locale,
     * poi elimina anche i record dalla tabella foto.
     */
    public void eliminaTutteLeFotoImmobile(Long immobileId) {
        List<Foto> fotoImmobile =
                fotoRepository.findByImmobileIdOrderByOrdinamentoAsc(immobileId);

        System.out.println("Eliminazione annuncio " + immobileId + ": trovate " + fotoImmobile.size() + " foto.");

        for (Foto foto : fotoImmobile) {
            try {
                eliminaFileFoto(immobileId, foto);
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException("Errore eliminando una foto dell'immobile " + immobileId);
            }
        }

        fotoRepository.deleteAll(fotoImmobile);

        System.out.println("Record foto eliminati dal database per immobile: " + immobileId);
    }

    private void eliminaFileFoto(Long immobileId, Foto foto) throws IOException {
        String objectKey = ricavaObjectKeyDaFoto(foto);

        if (objectKey != null && objectKey.startsWith("immobili/")) {
            eliminaDaR2(objectKey);
        } else {
            eliminaDaLocale(immobileId, foto.getNomeFile());
        }
    }

    private String ricavaObjectKeyDaFoto(Foto foto) {
        String nomeFile = foto.getNomeFile();
        String percorso = foto.getPercorso();
        String publicUrlPulito = pulisciUrl(publicUrl);

        /*
         * Caso nuovo corretto:
         * nomeFile = immobili/30/file.jpg
         */
        if (nomeFile != null && nomeFile.startsWith("immobili/")) {
            return nomeFile;
        }

        /*
         * Caso in cui abbiamo solo l'URL pubblico:
         * percorso = https://pub-xxx.r2.dev/immobili/30/file.jpg
         */
        if (percorso != null && percorso.startsWith(publicUrlPulito + "/")) {
            return percorso.substring((publicUrlPulito + "/").length());
        }

        /*
         * Caso vecchio locale:
         * percorso = /api/uploads/immobili/30/file.jpg
         */
        return null;
    }

    private void eliminaDaR2(String objectKey) {
        DeleteObjectRequest request = DeleteObjectRequest.builder()
                .bucket(bucketName)
                .key(objectKey)
                .build();

        s3Client.deleteObject(request);

        System.out.println("Foto eliminata da R2: " + objectKey);
    }

    private void eliminaDaLocale(Long immobileId, String nomeFile) throws IOException {
        if (nomeFile == null || nomeFile.isBlank()) {
            return;
        }

        Path filePath;

        /*
         * Se nomeFile è già un percorso vecchio tipo:
         * immobili/30/file.jpg
         * evitiamo di comporre male il path locale.
         */
        if (nomeFile.startsWith("immobili/")) {
            filePath = Paths.get("uploads").resolve(nomeFile).normalize();
        } else {
            filePath = uploadRoot
                    .resolve(immobileId.toString())
                    .resolve(nomeFile)
                    .normalize();
        }

        Files.deleteIfExists(filePath);

        System.out.println("Foto eliminata da locale: " + filePath);
    }

    public void aggiornaOrdineFoto(Long immobileId, List<String> percorsiOrdinati, Long userId) {
        Immobile immobile = immobileRepository.findById(immobileId)
                .orElseThrow(() -> new RuntimeException("Immobile non trovato"));

        if (!immobile.getUser().getId().equals(userId)) {
            throw new RuntimeException("Non autorizzato a riordinare foto per questo immobile");
        }

        if (percorsiOrdinati == null || percorsiOrdinati.isEmpty()) {
            throw new RuntimeException("Lista foto vuota");
        }

        List<Foto> fotoImmobile =
                fotoRepository.findByImmobileIdOrderByOrdinamentoAsc(immobileId);

        for (int i = 0; i < percorsiOrdinati.size(); i++) {
            String percorso = percorsiOrdinati.get(i);

            Foto fotoDaAggiornare = fotoImmobile.stream()
                    .filter(foto -> foto.getPercorso().equals(percorso))
                    .findFirst()
                    .orElseThrow(() -> new RuntimeException("Foto non trovata: " + percorso));

            fotoDaAggiornare.setOrdinamento(i);
            fotoRepository.save(fotoDaAggiornare);
        }
    }

    private void riordinaFoto(Long immobileId) {
        List<Foto> fotoRimanenti =
                fotoRepository.findByImmobileIdOrderByOrdinamentoAsc(immobileId);

        fotoRimanenti.sort(
                Comparator.comparing(
                        Foto::getOrdinamento,
                        Comparator.nullsLast(Integer::compareTo)
                )
        );

        for (int i = 0; i < fotoRimanenti.size(); i++) {
            Foto foto = fotoRimanenti.get(i);
            foto.setOrdinamento(i);
            fotoRepository.save(foto);
        }
    }

    public List<String> getFotoUrls(Long immobileId) {
        return fotoRepository.findByImmobileIdOrderByOrdinamentoAsc(immobileId)
                .stream()
                .map(Foto::getPercorso)
                .toList();
    }

    /*
     * Questo metodo resta solo per le vecchie immagini locali.
     * Le nuove immagini R2 vengono lette direttamente dal loro URL pubblico.
     */
    public Resource caricaFile(Long immobileId, String nomeFile) {
        try {
            Path filePath = uploadRoot
                    .resolve(immobileId.toString())
                    .resolve(nomeFile)
                    .normalize();

            Resource resource = new UrlResource(filePath.toUri());

            if (!resource.exists() || !resource.isReadable()) {
                throw new RuntimeException("File immagine non trovato");
            }

            return resource;

        } catch (MalformedURLException e) {
            throw new RuntimeException("File immagine non valido");
        }
    }

    private String pulisciUrl(String url) {
        if (url == null) {
            return "";
        }

        if (url.endsWith("/")) {
            return url.substring(0, url.length() - 1);
        }

        return url;
    }
}