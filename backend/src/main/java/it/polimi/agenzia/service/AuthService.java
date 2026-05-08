package it.polimi.agenzia.service;

import it.polimi.agenzia.dto.LoginRequest;
import it.polimi.agenzia.dto.LoginResponse;
import it.polimi.agenzia.entity.User;
import it.polimi.agenzia.repository.UserRepository;
import it.polimi.agenzia.security.JwtUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class AuthService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    public LoginResponse login(LoginRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("Utente non trovato"));
        
        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new RuntimeException("Password non valida");
        }
        
        String token = jwtUtil.generateToken(user.getId(), user.getEmail());
        
        return LoginResponse.builder()
                .token(token)
                .userId(user.getId())
                .email(user.getEmail())
                .nome(user.getNome())
                .cognome(user.getCognome())
                .role(user.getRole().toString())
                .build();
    }
}

