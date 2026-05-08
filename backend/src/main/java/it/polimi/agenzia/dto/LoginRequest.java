package it.polimi.agenzia.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LoginRequest {
    @Email(message = "Email non valida")
    @NotBlank(message = "Email è richiesta")
    private String email;

    @NotBlank(message = "Password è richiesta")
    private String password;
}

