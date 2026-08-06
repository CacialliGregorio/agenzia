package it.polimi.agenzia.service;

import it.polimi.agenzia.dto.ImmobileDTO;
import it.polimi.agenzia.entity.Immobile;
import it.polimi.agenzia.entity.User;
import it.polimi.agenzia.repository.FotoRepository;
import it.polimi.agenzia.repository.ImmobileRepository;
import it.polimi.agenzia.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.ArrayList;

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

    @Autowired
    private FotoService fotoService;

    public Page<ImmobileDTO> getImmobiliDisponibili(Pageable pageable) {
        return immobileRepository.findByStato(Immobile.Stato.DISPONIBILE, pageable)
                .map(this::convertToDTO);
    }

    public Page<ImmobileDTO> getTuttiImmobiliDashboard(Pageable pageable) {
        return immobileRepository.findAll(pageable)
                .map(this::convertToDTO);
    }
    public List<ImmobileDTO> getImmobiliSlide() {
        List<Immobile> immobiliSlide =
                immobileRepository.findByMostraInSlideTrueAndStatoOrderByIdAsc(
                        Immobile.Stato.DISPONIBILE
                );

        return immobiliSlide.stream()
                .limit(3)
                .map(this::convertToDTO)
                .toList();
    }

    @Transactional
    public List<ImmobileDTO> aggiornaImmobiliSlide(List<String> codiciRiferimento, Long userId) {
        User utenteCorrente = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Utente non trovato"));

        if (!isAdmin(utenteCorrente)) {
            throw new RuntimeException("Non autorizzato a modificare la slide");
        }

        List<String> codiciPuliti = codiciRiferimento == null
                ? new ArrayList<>()
                : codiciRiferimento.stream()
                .filter(codice -> codice != null && !codice.isBlank())
                .map(String::trim)
                .distinct()
                .limit(3)
                .toList();

        if (codiciPuliti.size() != 3) {
            throw new RuntimeException("Devi inserire esattamente 3 codici riferimento");
        }

        List<Immobile> selezionati = immobileRepository.findByCodiceRiferimentoIn(codiciPuliti);

        if (selezionati.size() != 3) {
            throw new RuntimeException("Uno o più codici riferimento non esistono");
        }

        List<Immobile> tutti = immobileRepository.findAll();

        for (Immobile immobile : tutti) {
            immobile.setMostraInSlide(false);
        }

        for (Immobile immobile : selezionati) {
            if (immobile.getStato() != Immobile.Stato.DISPONIBILE) {
                throw new RuntimeException("Gli immobili in slide devono essere disponibili");
            }

            immobile.setMostraInSlide(true);
        }

        immobileRepository.saveAll(tutti);

        return selezionati.stream()
                .map(this::convertToDTO)
                .toList();
    }

    public Page<ImmobileDTO> cercaImmobili(String citta,
                                           String tipo,
                                           String stato,
                                           BigDecimal prezzoMin,
                                           BigDecimal prezzoMax,
                                           Pageable pageable) {
        String tipoFiltro =
                tipo != null && !tipo.isBlank()
                        ? tipo
                        : null;

        Immobile.Stato statoEnum =
                stato != null && !stato.isBlank()
                        ? Immobile.Stato.valueOf(stato)
                        : Immobile.Stato.DISPONIBILE;

        return immobileRepository
                .cercaImmobili(citta, tipoFiltro, statoEnum, prezzoMin, prezzoMax, pageable)
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
                .codiceRiferimento(dto.getCodiceRiferimento())
                .mostraInSlide(Boolean.TRUE.equals(dto.getMostraInSlide()))
                .ubicazione(parseUbicazione(dto.getUbicazione()))
                .destinazione(parseDestinazione(dto.getDestinazione()))
                .tipo(dto.getTipo())
                .superficieMq(dto.getSuperficieMq())
                .numeroLocali(dto.getNumeroLocali())
                .numeroBagni(dto.getNumeroBagni())
                .camereDaLetto(dto.getCamereDaLetto())
                .piano(dto.getPiano())
                .ascensore(dto.getAscensore())
                .garage(Boolean.TRUE.equals(dto.getGarage()))
                .pannelliSolari(Boolean.TRUE.equals(dto.getPannelliSolari()))
                .terrazza(Boolean.TRUE.equals(dto.getTerrazza()))
                .riscaldamentoPavimento(Boolean.TRUE.equals(dto.getRiscaldamentoPavimento()))
                .giardino(Boolean.TRUE.equals(dto.getGiardino()))
                .piscina(Boolean.TRUE.equals(dto.getPiscina()))
                .impiantoAllarme(Boolean.TRUE.equals(dto.getImpiantoAllarme()))
                .ariaCondizionata(Boolean.TRUE.equals(dto.getAriaCondizionata()))
                .vistaPanoramica(Boolean.TRUE.equals(dto.getVistaPanoramica()))
                .ripostiglio(Boolean.TRUE.equals(dto.getRipostiglio()))
                .termoautonomo(Boolean.TRUE.equals(dto.getTermoautonomo()))
                .portaBlindata(Boolean.TRUE.equals(dto.getPortaBlindata()))
                .cappotto(Boolean.TRUE.equals(dto.getCappotto()))
                .cortilePrivato(Boolean.TRUE.equals(dto.getCortilePrivato()))
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

        User utenteCorrente = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Utente non trovato"));

        boolean proprietario = immobile.getUser().getId().equals(userId);
        boolean admin = isAdmin(utenteCorrente);

        if (!proprietario && !admin) {
            throw new RuntimeException("Non autorizzato a modificare questo immobile");
        }

        immobile.setTitolo(dto.getTitolo());
        immobile.setDescrizione(dto.getDescrizione());
        immobile.setPrezzo(dto.getPrezzo());
        immobile.setCitta(dto.getCitta());
        immobile.setProvincia(dto.getProvincia());
        immobile.setVia(dto.getVia());
        immobile.setNumeroCivico(dto.getNumeroCivico());
        immobile.setCodiceRiferimento(dto.getCodiceRiferimento());
        immobile.setMostraInSlide(Boolean.TRUE.equals(dto.getMostraInSlide()));
        immobile.setUbicazione(parseUbicazione(dto.getUbicazione()));
        immobile.setDestinazione(parseDestinazione(dto.getDestinazione()));
        immobile.setTipo(dto.getTipo());
        immobile.setSuperficieMq(dto.getSuperficieMq());
        immobile.setNumeroLocali(dto.getNumeroLocali());
        immobile.setNumeroBagni(dto.getNumeroBagni());
        immobile.setCamereDaLetto(dto.getCamereDaLetto());
        immobile.setPiano(dto.getPiano());
        immobile.setAscensore(dto.getAscensore());
        immobile.setGarage(Boolean.TRUE.equals(dto.getGarage()));
        immobile.setPannelliSolari(Boolean.TRUE.equals(dto.getPannelliSolari()));
        immobile.setTerrazza(Boolean.TRUE.equals(dto.getTerrazza()));
        immobile.setRiscaldamentoPavimento(Boolean.TRUE.equals(dto.getRiscaldamentoPavimento()));
        immobile.setGiardino(Boolean.TRUE.equals(dto.getGiardino()));
        immobile.setPiscina(Boolean.TRUE.equals(dto.getPiscina()));
        immobile.setImpiantoAllarme(Boolean.TRUE.equals(dto.getImpiantoAllarme()));
        immobile.setAriaCondizionata(Boolean.TRUE.equals(dto.getAriaCondizionata()));
        immobile.setVistaPanoramica(Boolean.TRUE.equals(dto.getVistaPanoramica()));
        immobile.setRipostiglio(Boolean.TRUE.equals(dto.getRipostiglio()));
        immobile.setTermoautonomo(Boolean.TRUE.equals(dto.getTermoautonomo()));
        immobile.setPortaBlindata(Boolean.TRUE.equals(dto.getPortaBlindata()));
        immobile.setCappotto(Boolean.TRUE.equals(dto.getCappotto()));
        immobile.setCortilePrivato(Boolean.TRUE.equals(dto.getCortilePrivato()));
        immobile.setRiscaldamento(dto.getRiscaldamento());

        if (dto.getStato() != null && !dto.getStato().isBlank()) {
            immobile.setStato(Immobile.Stato.valueOf(dto.getStato()));
        }

        immobile = immobileRepository.save(immobile);

        return convertToDTO(immobile);
    }

    @Transactional
    public void deleteImmobile(Long id, Long userId) {
        System.out.println("Richiesta eliminazione immobile: " + id + " da utente: " + userId);

        Immobile immobile = immobileRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Immobile non trovato"));

        User utenteCorrente = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Utente non trovato"));

        boolean proprietario = immobile.getUser().getId().equals(userId);
        boolean admin = isAdmin(utenteCorrente);

        System.out.println("Utente proprietario immobile: " + immobile.getUser().getId());
        System.out.println("Ruolo utente corrente: " + utenteCorrente.getRole());
        System.out.println("È proprietario? " + proprietario);
        System.out.println("È admin? " + admin);

        if (!proprietario && !admin) {
            System.out.println("Eliminazione bloccata: utente non autorizzato.");
            throw new RuntimeException("Non autorizzato a eliminare questo immobile");
        }

        /*
         * Prima eliminiamo tutte le foto fisiche da Cloudflare R2 o dal locale.
         * Poi eliminiamo l'immobile dal database.
         */
        fotoService.eliminaTutteLeFotoImmobile(id);

        immobileRepository.delete(immobile);

        System.out.println("Immobile eliminato dal database: " + id);
    }

    public String getNotePrivate(Long id, Long userId) {
        Immobile immobile = immobileRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Immobile non trovato"));

        User utenteCorrente = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Utente non trovato"));

        boolean proprietario = immobile.getUser().getId().equals(userId);
        boolean admin = isAdmin(utenteCorrente);

        if (!proprietario && !admin) {
            throw new RuntimeException("Non autorizzato a leggere le note di questo immobile");
        }

        return immobile.getNotePrivate();
    }

    @Transactional
    public String updateNotePrivate(Long id, String notePrivate, Long userId) {
        Immobile immobile = immobileRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Immobile non trovato"));

        User utenteCorrente = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Utente non trovato"));

        boolean proprietario = immobile.getUser().getId().equals(userId);
        boolean admin = isAdmin(utenteCorrente);

        if (!proprietario && !admin) {
            throw new RuntimeException("Non autorizzato a modificare le note di questo immobile");
        }

        immobile.setNotePrivate(notePrivate);
        immobileRepository.save(immobile);

        return immobile.getNotePrivate();
    }


    private boolean isAdmin(User user) {
        if (user == null || user.getRole() == null) {
            return false;
        }

        String ruolo = String.valueOf(user.getRole()).trim();

        return ruolo.equalsIgnoreCase("ADMIN")
                || ruolo.equalsIgnoreCase("ROLE_ADMIN");
    }

    private Immobile.Ubicazione parseUbicazione(String ubicazione) {
        if (ubicazione == null || ubicazione.isBlank()) {
            return null;
        }

        return Immobile.Ubicazione.valueOf(ubicazione);
    }

    private Immobile.Destinazione parseDestinazione(String destinazione) {
        if (destinazione == null || destinazione.isBlank()) {
            return null;
        }

        return Immobile.Destinazione.valueOf(destinazione);
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
                .codiceRiferimento(immobile.getCodiceRiferimento())
                .mostraInSlide(immobile.getMostraInSlide())
                .ubicazione(immobile.getUbicazione() != null ? immobile.getUbicazione().toString() : null)
                .destinazione(immobile.getDestinazione() != null ? immobile.getDestinazione().toString() : null)
                .tipo(immobile.getTipo())
                .superficieMq(immobile.getSuperficieMq())
                .numeroLocali(immobile.getNumeroLocali())
                .numeroBagni(immobile.getNumeroBagni())
                .camereDaLetto(immobile.getCamereDaLetto())
                .piano(immobile.getPiano())
                .ascensore(immobile.getAscensore())
                .garage(immobile.getGarage())
                .pannelliSolari(immobile.getPannelliSolari())
                .terrazza(immobile.getTerrazza())
                .riscaldamentoPavimento(immobile.getRiscaldamentoPavimento())
                .giardino(immobile.getGiardino())
                .piscina(immobile.getPiscina())
                .impiantoAllarme(immobile.getImpiantoAllarme())
                .ariaCondizionata(immobile.getAriaCondizionata())
                .vistaPanoramica(immobile.getVistaPanoramica())
                .ripostiglio(immobile.getRipostiglio())
                .termoautonomo(immobile.getTermoautonomo())
                .portaBlindata(immobile.getPortaBlindata())
                .cappotto(immobile.getCappotto())
                .cortilePrivato(immobile.getCortilePrivato())
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