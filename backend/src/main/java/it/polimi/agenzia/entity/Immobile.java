package it.polimi.agenzia.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "immobili")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Immobile {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String titolo;

    @Column(columnDefinition = "TEXT")
    private String descrizione;

    @Column(nullable = false)
    private BigDecimal prezzo;

    @Column(nullable = false)
    private String citta;

    private String provincia;

    private String via;

    @Column(name = "numero_civico")
    private String numeroCivico;
    @Column(name = "codice_riferimento")
    private String codiceRiferimento;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String tipo;

    @Enumerated(EnumType.STRING)
    private Ubicazione ubicazione;

    @Enumerated(EnumType.STRING)
    private Destinazione destinazione;

    @Column(name = "superficie_mq")
    private Double superficieMq;

    @Column(name = "numero_locali")
    private Integer numeroLocali;

    @Column(name = "numero_bagni")
    private Integer numeroBagni;

    @Column(name = "camere_da_letto")
    private Integer camereDaLetto;

    private Integer piano;

    private Boolean ascensore;
    private Boolean garage;
    @Column(name = "pannelli_solari")
    private Boolean pannelliSolari;

    private Boolean terrazza;

    @Column(name = "riscaldamento_pavimento")
    private Boolean riscaldamentoPavimento;

    private Boolean giardino;

    private Boolean piscina;

    @Column(name = "impianto_allarme")
    private Boolean impiantoAllarme;

    @Column(name = "aria_condizionata")
    private Boolean ariaCondizionata;

    @Column(name = "vista_panoramica")
    private Boolean vistaPanoramica;

    private Boolean ripostiglio;

    private Boolean termoautonomo;

    @Column(name = "porta_blindata")
    private Boolean portaBlindata;

    private Boolean cappotto;

    @Column(name = "cortile_privato")
    private Boolean cortilePrivato;

    private String riscaldamento;
    @Column(name = "note_private", columnDefinition = "TEXT")
    private String notePrivate;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Stato stato;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @OneToMany(mappedBy = "immobile", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Foto> foto;

    @Column(name = "creato_il", nullable = false, updatable = false)
    private LocalDateTime creatoIl;

    @Column(name = "aggiornato_il")
    private LocalDateTime aggiornatoIl;

    @PrePersist
    protected void onCreate() {
        creatoIl = LocalDateTime.now();
        aggiornatoIl = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        aggiornatoIl = LocalDateTime.now();
    }

    public enum Ubicazione {
        CENTRALE,
        FUORI_CITTA,
        PERIFERIA,
        SEMI_CENTRALE
    }

    public enum Destinazione {
        AFFITTO,
        AFFITTO_SEMI_ARREDATO,
        VENDITA
    }

    public enum TipoImmobile {
        CASA,
        APPARTAMENTO,
        TERRENO,
        GARAGE,
        VILLA,
        VILLETTA,
        MANSARDA,
        NEGOZIO,
        UFFICIO,

        ATTICO,
        ATTIVITA_COMMERCIALE,
        BILOCALE,
        BOX,
        CASA_INDIPENDENTE,
        CASCINA,
        FABBRICATO,
        LABORATORIO,
        LOFT,
        MAGAZZINO_CAPANNONE,
        MONOLOCALE,
        RUSTICO,
        STUDIO
    }
    public enum Stato {
        DISPONIBILE, VENDUTO, AFFITTATO
    }
}

