package it.polimi.agenzia.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "recensioni")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Recensione {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Integer voto;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String testo;

    @Column(name = "creato_il", nullable = false)
    private LocalDateTime creatoIl;

    @PrePersist
    protected void onCreate() {
        creatoIl = LocalDateTime.now();
    }
}