package it.polimi.agenzia.service;

import it.polimi.agenzia.dto.RecensioneDTO;
import it.polimi.agenzia.entity.Recensione;
import it.polimi.agenzia.repository.RecensioneRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class RecensioneService {

    @Autowired
    private RecensioneRepository recensioneRepository;

    public Page<RecensioneDTO> getRecensioni(Pageable pageable) {
        return recensioneRepository.findAllByOrderByVotoDescCreatoIlDesc(pageable)
                .map(this::convertToDTO);
    }

    public RecensioneDTO creaRecensione(RecensioneDTO dto) {
        if (dto.getVoto() == null || dto.getVoto() < 1 || dto.getVoto() > 5) {
            throw new RuntimeException("Il voto deve essere compreso tra 1 e 5");
        }

        if (dto.getTesto() == null || dto.getTesto().isBlank()) {
            throw new RuntimeException("Il testo della recensione è obbligatorio");
        }

        String testoPulito = dto.getTesto().trim();

        if (testoPulito.length() > 500) {
            throw new RuntimeException("La recensione non può superare i 500 caratteri");
        }

        Recensione recensione = Recensione.builder()
                .voto(dto.getVoto())
                .testo(testoPulito)
                .build();

        Recensione salvata = recensioneRepository.save(recensione);

        return convertToDTO(salvata);
    }

    private RecensioneDTO convertToDTO(Recensione recensione) {
        return RecensioneDTO.builder()
                .id(recensione.getId())
                .voto(recensione.getVoto())
                .testo(recensione.getTesto())
                .creatoIl(recensione.getCreatoIl())
                .build();
    }
}