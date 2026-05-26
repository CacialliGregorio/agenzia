package it.polimi.agenzia.config;

import it.polimi.agenzia.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class DevPasswordInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        List<String> emails = List.of(
                "admin@agenzia.it",
                "dipendente1@agenzia.it",
                "dipendente2@agenzia.it"
        );

        for (String email : emails) {
            userRepository.findByEmail(email).ifPresent(user -> {
                user.setPassword(passwordEncoder.encode("password123"));
                userRepository.save(user);
                System.out.println("Password aggiornata per: " + email);
            });
        }
    }
}