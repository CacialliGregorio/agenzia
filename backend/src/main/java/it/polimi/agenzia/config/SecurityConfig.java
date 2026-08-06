package it.polimi.agenzia.config;

import it.polimi.agenzia.security.JwtAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private JwtAuthenticationFilter jwtAuthenticationFilter;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable())
                .cors(cors -> cors.configurationSource(corsConfigurationSource()))
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(authz -> authz

                        // Login pubblico
                        .requestMatchers("/auth/**").permitAll()

                        // Recensioni pubbliche
                        .requestMatchers(HttpMethod.GET, "/recensioni/**").permitAll()
                        .requestMatchers(HttpMethod.POST, "/recensioni/**").permitAll()

                        // Lettura pubblica immobili
                        .requestMatchers(HttpMethod.GET, "/immobili/**").permitAll()
                        .requestMatchers(HttpMethod.GET, "/immobili/cerca").permitAll()

                        // Lettura pubblica immagini caricate
                        .requestMatchers(HttpMethod.GET, "/uploads/**").permitAll()
                        .requestMatchers(HttpMethod.GET, "/api/uploads/**").permitAll()

                        // Creazione/modifica/eliminazione immobili solo con login
                        .requestMatchers("/immobili/**").authenticated()

                        // Tutto il resto richiede login
                        .anyRequest().authenticated()
                )
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();

        configuration.setAllowedOriginPatterns(Arrays.asList(
                "http://localhost:3000",
                "http://localhost:5173",

                // Frontend Vercel attuale
                "https://agenzia-sooty.vercel.app",

                // Dominio tecnico Vercel della deployment
                "https://agenzia-omr2ub5wi-cacialligregorios-projects.vercel.app",

                // Qualsiasi sottodominio Vercel del progetto
                "https://*.vercel.app",

                // Dominio ufficiale
                "https://ilmondoimmobiliare.eu",
                "https://www.ilmondoimmobiliare.eu"
        ));

        configuration.setAllowedMethods(Arrays.asList(
                "GET",
                "POST",
                "PUT",
                "DELETE",
                "OPTIONS",
                "PATCH"
        ));

        configuration.setAllowedHeaders(Arrays.asList("*"));
        configuration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);

        return source;
    }
}