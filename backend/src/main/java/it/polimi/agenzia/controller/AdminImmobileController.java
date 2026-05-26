package it.polimi.agenzia.controller;

import it.polimi.agenzia.dto.ImmobileDTO;
import it.polimi.agenzia.service.ImmobileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
}