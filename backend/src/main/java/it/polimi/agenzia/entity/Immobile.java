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

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private TipoImmobile tipo;

    @Column(name = "superficie_mq")
    private Double superficieMq;

    @Column(name = "numero_locali")
    private Integer numeroLocali;

    @Column(name = "numero_bagni")
    private Integer numeroBagni;

    private Integer piano;

    private Boolean ascensore;

    private String riscaldamento;

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

    public enum TipoImmobile {
        CASA, APPARTAMENTO, TERRENO, GARAGE, VILLA, MANSARDA, NEGOZIO, UFFICIO
    }

    public enum Stato {
        DISPONIBILE, VENDUTO, AFFITTATO
    }
}

