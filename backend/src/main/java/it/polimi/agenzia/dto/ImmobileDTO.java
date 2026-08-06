package it.polimi.agenzia.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ImmobileDTO {
    private Long id;
    private String titolo;
    private String descrizione;
    private BigDecimal prezzo;
    private String citta;
    private String provincia;
    private String via;
    private String numeroCivico;
    private String codiceRiferimento;
    private Boolean mostraInSlide;
    private String ubicazione;
    private String destinazione;
    private String tipo;
    private Double superficieMq;
    private Integer numeroLocali;
    private Integer numeroBagni;
    private Integer camereDaLetto;
    private Integer piano;
    private Boolean ascensore;
    private Boolean garage;
    private Boolean pannelliSolari;
    private Boolean terrazza;
    private Boolean riscaldamentoPavimento;
    private Boolean giardino;
    private Boolean piscina;
    private Boolean impiantoAllarme;
    private Boolean ariaCondizionata;
    private Boolean vistaPanoramica;
    private Boolean ripostiglio;
    private Boolean termoautonomo;
    private Boolean portaBlindata;
    private Boolean cappotto;
    private Boolean cortilePrivato;
    private String riscaldamento;
    private String stato;
    private Long userId;
    private List<String> fotoUrl;
    private LocalDateTime creatoIl;
    private LocalDateTime aggiornatoIl;
}

