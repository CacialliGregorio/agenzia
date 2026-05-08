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
    private String tipo;
    private Double superficieMq;
    private Integer numeroLocali;
    private Integer numeroBagni;
    private Integer piano;
    private Boolean ascensore;
    private String riscaldamento;
    private String stato;
    private Long userId;
    private List<String> fotoUrl;
    private LocalDateTime creatoIl;
    private LocalDateTime aggiornatoIl;
}

