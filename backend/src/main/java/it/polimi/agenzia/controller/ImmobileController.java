package it.polimi.agenzia.controller;

import it.polimi.agenzia.dto.ImmobileDTO;
import it.polimi.agenzia.service.ImmobileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;

import java.math.BigDecimal;

@RestController
@RequestMapping("/immobili")
@CrossOrigin(origins = {"http://localhost:3000", "http://localhost:5173"})
public class ImmobileController {
    
    @Autowired
    private ImmobileService immobileService;
    
    @GetMapping
    public ResponseEntity<Page<ImmobileDTO>> getImmobiliDisponibili(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size) {
        Pageable pageable = PageRequest.of(page, size);
        return ResponseEntity.ok(immobileService.getImmobiliDisponibili(pageable));
    }
    @GetMapping("/slide")
    public ResponseEntity<List<ImmobileDTO>> getImmobiliSlide() {
        return ResponseEntity.ok(immobileService.getImmobiliSlide());
    }
    
    @GetMapping("/cerca")
    public ResponseEntity<Page<ImmobileDTO>> cercaImmobili(
            @RequestParam(required = false) String citta,
            @RequestParam(required = false) String tipo,
            @RequestParam(required = false) String stato,
            @RequestParam(required = false) BigDecimal prezzoMin,
            @RequestParam(required = false) BigDecimal prezzoMax,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size) {
        
        if (prezzoMin == null) prezzoMin = BigDecimal.ZERO;
        if (prezzoMax == null) prezzoMax = new BigDecimal("999999999");
        
        Pageable pageable = PageRequest.of(page, size);
        return ResponseEntity.ok(immobileService.cercaImmobili(citta, tipo, stato, prezzoMin, prezzoMax, pageable));
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<ImmobileDTO> getImmobileById(@PathVariable Long id) {
        try {
            return ResponseEntity.ok(immobileService.getImmobileById(id));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }
    
    @PostMapping
    public ResponseEntity<ImmobileDTO> createImmobile(
            @RequestBody ImmobileDTO dto,
            Authentication authentication) {
        try {
            Long userId = (Long) authentication.getDetails();
            ImmobileDTO created = immobileService.createImmobile(dto, userId);
            return ResponseEntity.status(HttpStatus.CREATED).body(created);
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().build();
        }
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<ImmobileDTO> updateImmobile(
            @PathVariable Long id,
            @RequestBody ImmobileDTO dto,
            Authentication authentication) {
        try {
            Long userId = (Long) authentication.getDetails();
            ImmobileDTO updated = immobileService.updateImmobile(id, dto, userId);
            return ResponseEntity.ok(updated);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteImmobile(
            @PathVariable Long id,
            Authentication authentication) {
        try {
            Long userId = (Long) authentication.getDetails();
            immobileService.deleteImmobile(id, userId);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
    }
}

