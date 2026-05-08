package it.polimi.agenzia.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String nome;

    @Column(nullable = false)
    private String cognome;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

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

    public enum Role {
        ADMIN, EMPLOYEE
    }
}

