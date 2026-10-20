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

    public List<String> caricaFoto(
            Long immobileId,
            List<MultipartFile> files,
            Long userId) {

        System.out.println("========== INIZIO UPLOAD FOTO ==========");
        System.out.println("Immobile ID: " + immobileId);
        System.out.println("User ID: " + userId);
        System.out.println("Bucket R2: " + bucketName);
        System.out.println("Public URL R2: " + publicUrl);
        System.out.println(
                "Numero file ricevuti: "
                        + (files != null ? files.size() : 0)
        );

        Immobile immobile = immobileRepository.findById(immobileId)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Immobile non trovato: " + immobileId
                        )
                );

        if (immobile.getUser() == null) {
            throw new RuntimeException(
                    "L'immobile non ha un utente associato"
            );
        }

        System.out.println(
                "Proprietario immobile: "
                        + immobile.getUser().getId()
        );

        if (!immobile.getUser().getId().equals(userId)) {
            throw new RuntimeException(
                    "Non autorizzato a caricare foto per questo immobile"
            );
        }

        if (files == null || files.isEmpty()) {
            throw new RuntimeException("Nessuna foto caricata");
        }

        List<String> percorsiSalvati = new ArrayList<>();

        try {

            List<Foto> fotoEsistenti =
                    fotoRepository
                            .findByImmobileIdOrderByOrdinamentoAsc(
                                    immobileId
                            );

            int ordinamento = fotoEsistenti.size();

            System.out.println(
                    "Foto già presenti: " + fotoEsistenti.size()
            );

            for (MultipartFile file : files) {

                if (file == null || file.isEmpty()) {
                    System.out.println(
                            "File vuoto ignorato"
                    );
                    continue;
                }

                System.out.println("--------------------------------");
                System.out.println(
                        "Nome originale: "
                                + file.getOriginalFilename()
                );
                System.out.println(
                        "Content-Type: "
                                + file.getContentType()
                );
                System.out.println(
                        "Dimensione originale: "
                                + file.getSize()
                                + " bytes"
                );

                validaFileImmagine(file);

                System.out.println(
                        "Validazione immagine OK"
                );

                String nomeFile =
                        System.currentTimeMillis()
                                + "-"
                                + UUID.randomUUID()
                                + ".jpg";

                String objectKey =
                        "immobili/"
                                + immobileId
                                + "/"
                                + nomeFile;

                System.out.println(
                        "Object key R2: " + objectKey
                );

                System.out.println(
                        "Inizio compressione immagine..."
                );

                byte[] immagineCompressa =
                        comprimiImmagine(file);

                System.out.println(
                        "Compressione completata. Dimensione: "
                                + immagineCompressa.length
                                + " bytes"
                );

                System.out.println(
                        "Inizio upload Cloudflare R2..."
                );

                caricaSuR2(
                        objectKey,
                        immagineCompressa
                );

                System.out.println(
                        "Upload Cloudflare R2 completato"
                );

                String percorsoPubblico =
                        pulisciUrl(publicUrl)
                                + "/"
                                + objectKey;

                System.out.println(
                        "URL pubblico foto: "
                                + percorsoPubblico
                );

                Foto foto = Foto.builder()
                        .immobile(immobile)
                        .nomeFile(objectKey)
                        .percorso(percorsoPubblico)
                        .ordinamento(ordinamento)
                        .build();

                System.out.println(
                        "Salvataggio record foto nel database..."
                );

                fotoRepository.save(foto);

                System.out.println(
                        "Record foto salvato nel database"
                );

                percorsiSalvati.add(
                        percorsoPubblico
                );

                ordinamento++;
            }

            System.out.println(
                    "========== UPLOAD FOTO COMPLETATO =========="
            );

            return percorsiSalvati;

        } catch (IOException e) {

            System.err.println(
                    "ERRORE COMPRESSIONE IMMAGINE"
            );

            System.err.println(
                    e.getClass().getName()
                            + ": "
                            + e.getMessage()
            );

            e.printStackTrace();

            throw new RuntimeException(
                    "Errore durante la compressione delle immagini: "
                            + e.getMessage(),
                    e
            );

        } catch (Exception e) {

            System.err.println(
                    "ERRORE DURANTE UPLOAD FOTO"
            );

            System.err.println(
                    "Tipo errore: "
                            + e.getClass().getName()
            );

            System.err.println(
                    "Messaggio: "
                            + e.getMessage()
            );

            e.printStackTrace();

            throw new RuntimeException(
                    "Errore upload foto: "
                            + e.getClass().getSimpleName()
                            + " - "
                            + e.getMessage(),
                    e
            );
        }
    }

    private void validaFileImmagine(
            MultipartFile file) {

        String contentType =
                file.getContentType();

        if (contentType == null
                || !contentType.startsWith("image/")) {

            throw new RuntimeException(
                    "Puoi caricare solo file immagine"
            );
        }

        String nomeOriginale =
                file.getOriginalFilename();

        if (nomeOriginale == null
                || nomeOriginale.isBlank()) {

            throw new RuntimeException(
                    "Nome file immagine non valido"
            );
        }

        String nomeMinuscolo =
                nomeOriginale.toLowerCase();

        boolean estensioneValida =
                nomeMinuscolo.endsWith(".jpg")
                        || nomeMinuscolo.endsWith(".jpeg")
                        || nomeMinuscolo.endsWith(".png")
                        || nomeMinuscolo.endsWith(".webp");

        if (!estensioneValida) {

            throw new RuntimeException(
                    "Formato immagine non supportato. "
                            + "Usa JPG, JPEG, PNG o WEBP"
            );
        }
    }

    private byte[] comprimiImmagine(
            MultipartFile file)
            throws IOException {

        ByteArrayOutputStream outputStream =
                new ByteArrayOutputStream();

        Thumbnails.of(
                        file.getInputStream()
                )
                .size(
                        LARGHEZZA_MASSIMA,
                        ALTEZZA_MASSIMA
                )
                .outputFormat("jpg")
                .outputQuality(
                        QUALITA_JPG
                )
                .toOutputStream(
                        outputStream
                );

        return outputStream.toByteArray();
    }

    private void caricaSuR2(
            String objectKey,
            byte[] bytes) {

        System.out.println(
                "Preparazione PutObjectRequest..."
        );

        System.out.println(
                "Bucket: " + bucketName
        );

        System.out.println(
                "Key: " + objectKey
        );

        System.out.println(
                "Bytes: " + bytes.length
        );

        PutObjectRequest request =
                PutObjectRequest.builder()
                        .bucket(bucketName)
                        .key(objectKey)
                        .contentType("image/jpeg")
                        .contentLength(
                                (long) bytes.length
                        )
                        .build();

        s3Client.putObject(
                request,
                RequestBody.fromBytes(bytes)
        );

        System.out.println(
                "Foto caricata su R2: "
                        + objectKey
        );
    }

    public void eliminaFoto(
            Long immobileId,
            String percorso,
            Long userId) {

        Immobile immobile =
                immobileRepository
                        .findById(immobileId)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Immobile non trovato"
                                )
                        );

        if (!immobile
                .getUser()
                .getId()
                .equals(userId)) {

            throw new RuntimeException(
                    "Non autorizzato a eliminare foto per questo immobile"
            );
        }

        List<Foto> fotoImmobile =
                fotoRepository
                        .findByImmobileIdOrderByOrdinamentoAsc(
                                immobileId
                        );

        Foto fotoDaEliminare =
                fotoImmobile
                        .stream()
                        .filter(foto ->
                                foto
                                        .getPercorso()
                                        .equals(percorso)
                        )
                        .findFirst()
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Foto non trovata"
                                )
                        );

        try {

            eliminaFileFoto(
                    immobileId,
                    fotoDaEliminare
            );

        } catch (Exception e) {

            e.printStackTrace();

            throw new RuntimeException(
                    "Errore durante l'eliminazione del file immagine"
            );
        }

        fotoRepository.delete(
                fotoDaEliminare
        );

        riordinaFoto(
                immobileId
        );
    }

    public void eliminaTutteLeFotoImmobile(
            Long immobileId) {

        List<Foto> fotoImmobile =
                fotoRepository
                        .findByImmobileIdOrderByOrdinamentoAsc(
                                immobileId
                        );

        System.out.println(
                "Eliminazione annuncio "
                        + immobileId
                        + ": trovate "
                        + fotoImmobile.size()
                        + " foto."
        );

        for (Foto foto : fotoImmobile) {

            try {

                eliminaFileFoto(
                        immobileId,
                        foto
                );

            } catch (Exception e) {

                System.out.println(
                        "Impossibile eliminare fisicamente la foto "
                                + foto.getId()
                                + " dell'immobile "
                                + immobileId
                                + ". Continuo comunque con "
                                + "l'eliminazione dal database."
                );

                e.printStackTrace();
            }
        }

        fotoRepository.deleteAll(
                fotoImmobile
        );

        System.out.println(
                "Record foto eliminati dal database per immobile: "
                        + immobileId
        );
    }

    private void eliminaFileFoto(
            Long immobileId,
            Foto foto)
            throws IOException {

        String objectKey =
                ricavaObjectKeyDaFoto(foto);

        if (objectKey != null
                && objectKey.startsWith("immobili/")) {

            eliminaDaR2(
                    objectKey
            );

        } else {

            eliminaDaLocale(
                    immobileId,
                    foto.getNomeFile()
            );
        }
    }

    private String ricavaObjectKeyDaFoto(
            Foto foto) {

        String nomeFile =
                foto.getNomeFile();

        String percorso =
                foto.getPercorso();

        String publicUrlPulito =
                pulisciUrl(publicUrl);

        if (nomeFile != null
                && nomeFile.startsWith("immobili/")) {

            return nomeFile;
        }

        if (percorso != null
                && percorso.startsWith(
                publicUrlPulito + "/"
        )) {

            return percorso.substring(
                    (publicUrlPulito + "/")
                            .length()
            );
        }

        return null;
    }

    private void eliminaDaR2(
            String objectKey) {

        DeleteObjectRequest request =
                DeleteObjectRequest.builder()
                        .bucket(bucketName)
                        .key(objectKey)
                        .build();

        s3Client.deleteObject(
                request
        );

        System.out.println(
                "Foto eliminata da R2: "
                        + objectKey
        );
    }

    private void eliminaDaLocale(
            Long immobileId,
            String nomeFile)
            throws IOException {

        if (nomeFile == null
                || nomeFile.isBlank()) {

            return;
        }

        Path filePath;

        if (nomeFile.startsWith("immobili/")) {

            filePath =
                    Paths.get("uploads")
                            .resolve(nomeFile)
                            .normalize();

        } else {

            filePath =
                    uploadRoot
                            .resolve(
                                    immobileId.toString()
                            )
                            .resolve(nomeFile)
                            .normalize();
        }

        Files.deleteIfExists(
                filePath
        );

        System.out.println(
                "Foto eliminata da locale: "
                        + filePath
        );
    }

    public void aggiornaOrdineFoto(
            Long immobileId,
            List<String> percorsiOrdinati,
            Long userId) {

        Immobile immobile =
                immobileRepository
                        .findById(immobileId)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Immobile non trovato"
                                )
                        );

        if (!immobile
                .getUser()
                .getId()
                .equals(userId)) {

            throw new RuntimeException(
                    "Non autorizzato a riordinare foto per questo immobile"
            );
        }

        if (percorsiOrdinati == null
                || percorsiOrdinati.isEmpty()) {

            throw new RuntimeException(
                    "Lista foto vuota"
            );
        }

        List<Foto> fotoImmobile =
                fotoRepository
                        .findByImmobileIdOrderByOrdinamentoAsc(
                                immobileId
                        );

        for (int i = 0;
             i < percorsiOrdinati.size();
             i++) {

            String percorso =
                    percorsiOrdinati.get(i);

            Foto fotoDaAggiornare =
                    fotoImmobile
                            .stream()
                            .filter(foto ->
                                    foto
                                            .getPercorso()
                                            .equals(percorso)
                            )
                            .findFirst()
                            .orElseThrow(() ->
                                    new RuntimeException(
                                            "Foto non trovata: "
                                                    + percorso
                                    )
                            );

            fotoDaAggiornare
                    .setOrdinamento(i);

            fotoRepository.save(
                    fotoDaAggiornare
            );
        }
    }

    private void riordinaFoto(
            Long immobileId) {

        List<Foto> fotoRimanenti =
                fotoRepository
                        .findByImmobileIdOrderByOrdinamentoAsc(
                                immobileId
                        );

        fotoRimanenti.sort(
                Comparator.comparing(
                        Foto::getOrdinamento,
                        Comparator.nullsLast(
                                Integer::compareTo
                        )
                )
        );

        for (int i = 0;
             i < fotoRimanenti.size();
             i++) {

            Foto foto =
                    fotoRimanenti.get(i);

            foto.setOrdinamento(i);

            fotoRepository.save(
                    foto
            );
        }
    }

    public List<String> getFotoUrls(
            Long immobileId) {

        return fotoRepository
                .findByImmobileIdOrderByOrdinamentoAsc(
                        immobileId
                )
                .stream()
                .map(Foto::getPercorso)
                .toList();
    }

    public Resource caricaFile(
            Long immobileId,
            String nomeFile) {

        try {

            Path filePath =
                    uploadRoot
                            .resolve(
                                    immobileId.toString()
                            )
                            .resolve(nomeFile)
                            .normalize();

            Resource resource =
                    new UrlResource(
                            filePath.toUri()
                    );

            if (!resource.exists()
                    || !resource.isReadable()) {

                throw new RuntimeException(
                        "File immagine non trovato"
                );
            }

            return resource;

        } catch (MalformedURLException e) {

            throw new RuntimeException(
                    "File immagine non valido"
            );
        }
    }

    private String pulisciUrl(
            String url) {

        if (url == null) {
            return "";
        }

        if (url.endsWith("/")) {
            return url.substring(
                    0,
                    url.length() - 1
            );
        }

        return url;
    }
}