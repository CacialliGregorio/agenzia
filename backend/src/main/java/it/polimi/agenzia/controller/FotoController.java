package it.polimi.agenzia.controller;

import it.polimi.agenzia.service.FotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping
@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:5173"})
public class FotoController {

    @Autowired
    private FotoService fotoService;

    @PostMapping("/immobili/{immobileId}/foto")
    public ResponseEntity<List<String>> caricaFoto(
            @PathVariable Long immobileId,
            @RequestParam("files") List<MultipartFile> files,
            Authentication authentication) {

        try {
            Long userId = (Long) authentication.getDetails();

            List<String> fotoUrls = fotoService.caricaFoto(
                    immobileId,
                    files,
                    userId
            );

            return ResponseEntity.ok(fotoUrls);

        } catch (RuntimeException e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    @DeleteMapping("/immobili/{immobileId}/foto")
    public ResponseEntity<Void> eliminaFoto(
            @PathVariable Long immobileId,
            @RequestParam String percorso,
            Authentication authentication) {

        try {
            Long userId = (Long) authentication.getDetails();

            fotoService.eliminaFoto(
                    immobileId,
                    percorso,
                    userId
            );

            return ResponseEntity.noContent().build();

        } catch (RuntimeException e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    @PutMapping("/immobili/{immobileId}/foto/ordine")
    public ResponseEntity<Void> aggiornaOrdineFoto(
            @PathVariable Long immobileId,
            @RequestBody Map<String, List<String>> request,
            Authentication authentication) {

        try {
            Long userId = (Long) authentication.getDetails();

            List<String> percorsiOrdinati = request.get("fotoUrl");

            fotoService.aggiornaOrdineFoto(
                    immobileId,
                    percorsiOrdinati,
                    userId
            );

            return ResponseEntity.noContent().build();

        } catch (RuntimeException e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/uploads/immobili/{immobileId}/{nomeFile:.+}")
    public ResponseEntity<Resource> visualizzaFoto(
            @PathVariable Long immobileId,
            @PathVariable String nomeFile) {

        Resource resource = fotoService.caricaFile(immobileId, nomeFile);

        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_JPEG)
                .header(
                        HttpHeaders.CONTENT_DISPOSITION,
                        "inline; filename=\"" + resource.getFilename() + "\""
                )
                .body(resource);
    }
}