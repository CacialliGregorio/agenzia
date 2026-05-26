package it.polimi.agenzia.service;

import it.polimi.agenzia.entity.Foto;
import it.polimi.agenzia.entity.Immobile;
import it.polimi.agenzia.repository.FotoRepository;
import it.polimi.agenzia.repository.ImmobileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class FotoService {

    private final Path uploadRoot = Paths.get("uploads", "immobili");

    @Autowired
    private FotoRepository fotoRepository;

    @Autowired
    private ImmobileRepository immobileRepository;

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
            Path cartellaImmobile = uploadRoot.resolve(immobileId.toString());
            Files.createDirectories(cartellaImmobile);

            List<Foto> fotoEsistenti = fotoRepository.findByImmobileIdOrderByOrdinamentoAsc(immobileId);
            int ordinamento = fotoEsistenti.size();

            for (MultipartFile file : files) {
                if (file.isEmpty()) {
                    continue;
                }

                String contentType = file.getContentType();

                if (contentType == null || !contentType.startsWith("image/")) {
                    throw new RuntimeException("Puoi caricare solo file immagine");
                }

                String nomeOriginale = file.getOriginalFilename();
                String estensione = estraiEstensione(nomeOriginale);

                String nomeFile = System.currentTimeMillis()
                        + "-"
                        + UUID.randomUUID()
                        + estensione;

                Path destinazione = cartellaImmobile.resolve(nomeFile);

                Files.copy(file.getInputStream(), destinazione, StandardCopyOption.REPLACE_EXISTING);

                String percorsoPubblico = "/api/uploads/immobili/" + immobileId + "/" + nomeFile;

                Foto foto = Foto.builder()
                        .immobile(immobile)
                        .nomeFile(nomeFile)
                        .percorso(percorsoPubblico)
                        .ordinamento(ordinamento)
                        .build();

                fotoRepository.save(foto);

                percorsiSalvati.add(percorsoPubblico);
                ordinamento++;
            }

            return percorsiSalvati;

        } catch (IOException e) {
            throw new RuntimeException("Errore durante il salvataggio delle immagini");
        }
    }

    public List<String> getFotoUrls(Long immobileId) {
        return fotoRepository.findByImmobileIdOrderByOrdinamentoAsc(immobileId)
                .stream()
                .map(Foto::getPercorso)
                .toList();
    }

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

    private String estraiEstensione(String nomeFile) {
        if (nomeFile == null || !nomeFile.contains(".")) {
            return ".jpg";
        }

        return nomeFile.substring(nomeFile.lastIndexOf("."));
    }
}