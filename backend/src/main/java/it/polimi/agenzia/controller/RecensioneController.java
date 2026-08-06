package it.polimi.agenzia.controller;

import it.polimi.agenzia.dto.RecensioneDTO;
import it.polimi.agenzia.service.RecensioneService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/recensioni")
public class RecensioneController {

    @Autowired
    private RecensioneService recensioneService;

    @GetMapping
    public ResponseEntity<Page<RecensioneDTO>> getRecensioni(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size) {

        Pageable pageable = PageRequest.of(page, size);

        return ResponseEntity.ok(recensioneService.getRecensioni(pageable));
    }

    @PostMapping
    public ResponseEntity<?> creaRecensione(@RequestBody RecensioneDTO recensioneDTO) {
        try {
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(recensioneService.creaRecensione(recensioneDTO));
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}