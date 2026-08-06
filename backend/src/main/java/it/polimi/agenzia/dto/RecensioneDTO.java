package it.polimi.agenzia.dto;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RecensioneDTO {

    private Long id;
    private Integer voto;
    private String testo;
    private LocalDateTime creatoIl;
}