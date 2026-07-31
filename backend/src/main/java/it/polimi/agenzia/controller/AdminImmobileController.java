package it.polimi.agenzia.controller;

import it.polimi.agenzia.dto.ImmobileDTO;
import it.polimi.agenzia.service.ImmobileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import java.util.Map;

@RestController
@RequestMapping("/admin/immobili")
@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:5173"})
public class AdminImmobileController {

    @Autowired
    private ImmobileService immobileService;

    @GetMapping
    public ResponseEntity<Page<ImmobileDTO>> getTuttiImmobiliDashboard(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "100") int size) {

        Pageable pageable = PageRequest.of(page, size);

        return ResponseEntity.ok(
                immobileService.getTuttiImmobiliDashboard(pageable)
        );
    }

    @GetMapping("/{id}/note")
    public ResponseEntity<Map<String, String>> getNotePrivate(
            @PathVariable Long id,
            Authentication authentication) {
        try {
            Long userId = (Long) authentication.getDetails();

            String notePrivate = immobileService.getNotePrivate(id, userId);

            return ResponseEntity.ok(
                    Map.of("notePrivate", notePrivate != null ? notePrivate : "")
            );
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
    }

    @PutMapping("/{id}/note")
    public ResponseEntity<Map<String, String>> updateNotePrivate(
            @PathVariable Long id,
            @RequestBody Map<String, String> body,
            Authentication authentication) {
        try {
            Long userId = (Long) authentication.getDetails();

            String notePrivate = body.getOrDefault("notePrivate", "");

            String savedNote = immobileService.updateNotePrivate(id, notePrivate, userId);

            return ResponseEntity.ok(
                    Map.of("notePrivate", savedNote != null ? savedNote : "")
            );
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
    }
}