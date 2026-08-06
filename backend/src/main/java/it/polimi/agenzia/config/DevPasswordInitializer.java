package it.polimi.agenzia.config;

import it.polimi.agenzia.entity.User;
import it.polimi.agenzia.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class DevPasswordInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        String email = "agenzia@ilmondoimmobiliare.eu";
        String password = "Trieste120.";

        User user = userRepository.findByEmail(email)
                .orElseGet(() -> User.builder()
                        .email(email)
                        .nome("Agenzia")
                        .cognome("Il Mondo Immobiliare")
                        .role(User.Role.ADMIN)
                        .build()
                );

        user.setPassword(passwordEncoder.encode(password));
        user.setNome("Agenzia");
        user.setCognome("Il Mondo Immobiliare");
        user.setRole(User.Role.ADMIN);

        userRepository.save(user);

        System.out.println("Utente dashboard configurato: " + email);
    }
}