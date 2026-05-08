package it.polimi.agenzia.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "foto")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Foto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "immobile_id", nullable = false)
    private Immobile immobile;

    @Column(name = "nome_file", nullable = false)
    private String nomeFile;

    @Column(nullable = false)
    private String percorso;

    private Integer ordinamento;

    @Column(name = "creato_il", nullable = false, updatable = false)
    private LocalDateTime creatoIl;

    @PrePersist
    protected void onCreate() {
        creatoIl = LocalDateTime.now();
    }
}

