package it.polimi.agenzia.service;

import it.polimi.agenzia.dto.ImmobileDTO;
import it.polimi.agenzia.entity.Immobile;
import it.polimi.agenzia.entity.User;
import it.polimi.agenzia.repository.FotoRepository;
import it.polimi.agenzia.repository.ImmobileRepository;
import it.polimi.agenzia.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Service
@Slf4j
public class ImmobileService {

    @Autowired
    private ImmobileRepository immobileRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private FotoRepository fotoRepository;

    public Page<ImmobileDTO> getImmobiliDisponibili(Pageable pageable) {
        return immobileRepository.findByStato(Immobile.Stato.DISPONIBILE, pageable)
                .map(this::convertToDTO);
    }

    public Page<ImmobileDTO> getTuttiImmobiliDashboard(Pageable pageable) {
        return immobileRepository.findAll(pageable)
                .map(this::convertToDTO);
    }

    public Page<ImmobileDTO> cercaImmobili(String citta,
                                           String tipo,
                                           String stato,
                                           BigDecimal prezzoMin,
                                           BigDecimal prezzoMax,
                                           Pageable pageable) {
        Immobile.TipoImmobile tipoEnum =
                tipo != null && !tipo.isBlank()
                        ? Immobile.TipoImmobile.valueOf(tipo)
                        : null;

        Immobile.Stato statoEnum =
                stato != null && !stato.isBlank()
                        ? Immobile.Stato.valueOf(stato)
                        : Immobile.Stato.DISPONIBILE;

        return immobileRepository
                .cercaImmobili(citta, tipoEnum, statoEnum, prezzoMin, prezzoMax, pageable)
                .map(this::convertToDTO);
    }

    public ImmobileDTO getImmobileById(Long id) {
        Immobile immobile = immobileRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Immobile non trovato"));

        return convertToDTO(immobile);
    }

    public ImmobileDTO createImmobile(ImmobileDTO dto, Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Utente non trovato"));

        Immobile.Stato stato =
                dto.getStato() != null && !dto.getStato().isBlank()
                        ? Immobile.Stato.valueOf(dto.getStato())
                        : Immobile.Stato.DISPONIBILE;

        Immobile immobile = Immobile.builder()
                .titolo(dto.getTitolo())
                .descrizione(dto.getDescrizione())
                .prezzo(dto.getPrezzo())
                .citta(dto.getCitta())
                .provincia(dto.getProvincia())
                .via(dto.getVia())
                .numeroCivico(dto.getNumeroCivico())
                .tipo(Immobile.TipoImmobile.valueOf(dto.getTipo()))
                .superficieMq(dto.getSuperficieMq())
                .numeroLocali(dto.getNumeroLocali())
                .numeroBagni(dto.getNumeroBagni())
                .piano(dto.getPiano())
                .ascensore(dto.getAscensore())
                .riscaldamento(dto.getRiscaldamento())
                .stato(stato)
                .user(user)
                .build();

        immobile = immobileRepository.save(immobile);

        return convertToDTO(immobile);
    }

    public ImmobileDTO updateImmobile(Long id, ImmobileDTO dto, Long userId) {
        Immobile immobile = immobileRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Immobile non trovato"));

        if (!immobile.getUser().getId().equals(userId)) {
            throw new RuntimeException("Non autorizzato a modificare questo immobile");
        }

        immobile.setTitolo(dto.getTitolo());
        immobile.setDescrizione(dto.getDescrizione());
        immobile.setPrezzo(dto.getPrezzo());
        immobile.setCitta(dto.getCitta());
        immobile.setProvincia(dto.getProvincia());
        immobile.setVia(dto.getVia());
        immobile.setNumeroCivico(dto.getNumeroCivico());
        immobile.setTipo(Immobile.TipoImmobile.valueOf(dto.getTipo()));
        immobile.setSuperficieMq(dto.getSuperficieMq());
        immobile.setNumeroLocali(dto.getNumeroLocali());
        immobile.setNumeroBagni(dto.getNumeroBagni());
        immobile.setPiano(dto.getPiano());
        immobile.setAscensore(dto.getAscensore());
        immobile.setRiscaldamento(dto.getRiscaldamento());

        if (dto.getStato() != null && !dto.getStato().isBlank()) {
            immobile.setStato(Immobile.Stato.valueOf(dto.getStato()));
        }

        immobile = immobileRepository.save(immobile);

        return convertToDTO(immobile);
    }

    public void deleteImmobile(Long id, Long userId) {
        Immobile immobile = immobileRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Immobile non trovato"));

        if (!immobile.getUser().getId().equals(userId)) {
            throw new RuntimeException("Non autorizzato a eliminare questo immobile");
        }

        immobileRepository.delete(immobile);
    }

    private ImmobileDTO convertToDTO(Immobile immobile) {
        return ImmobileDTO.builder()
                .id(immobile.getId())
                .titolo(immobile.getTitolo())
                .descrizione(immobile.getDescrizione())
                .prezzo(immobile.getPrezzo())
                .citta(immobile.getCitta())
                .provincia(immobile.getProvincia())
                .via(immobile.getVia())
                .numeroCivico(immobile.getNumeroCivico())
                .tipo(immobile.getTipo().toString())
                .superficieMq(immobile.getSuperficieMq())
                .numeroLocali(immobile.getNumeroLocali())
                .numeroBagni(immobile.getNumeroBagni())
                .piano(immobile.getPiano())
                .ascensore(immobile.getAscensore())
                .riscaldamento(immobile.getRiscaldamento())
                .stato(immobile.getStato().toString())
                .userId(immobile.getUser().getId())
                .fotoUrl(
                        fotoRepository.findByImmobileIdOrderByOrdinamentoAsc(immobile.getId())
                                .stream()
                                .map(foto -> foto.getPercorso())
                                .toList()
                )
                .creatoIl(immobile.getCreatoIl())
                .aggiornatoIl(immobile.getAggiornatoIl())
                .build();
    }
}