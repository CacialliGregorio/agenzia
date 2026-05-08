-- V2__Insert_sample_data.sql

-- Insert sample users (password: "password123")
INSERT INTO users (email, password, nome, cognome, role) VALUES
('admin@agenzia.it', '$2a$10$SlZvb7nCfDz3g/S1WkfqEesS9ydJdZqfnUzUv0f5vVP0lZG9K3Tay', 'Admin', 'Agenzia', 'ADMIN'),
('dipendente1@agenzia.it', '$2a$10$SlZvb7nCfDz3g/S1WkfqEesS9ydJdZqfnUzUv0f5vVP0lZG9K3Tay', 'Marco', 'Rossi', 'EMPLOYEE'),
('dipendente2@agenzia.it', '$2a$10$SlZvb7nCfDz3g/S1WkfqEesS9ydJdZqfnUzUv0f5vVP0lZG9K3Tay', 'Laura', 'Bianchi', 'EMPLOYEE');

-- Insert sample immobili
INSERT INTO immobili (titolo, descrizione, prezzo, citta, provincia, via, numero_civico, tipo, superficie_mq, numero_locali, numero_bagni, piano, ascensore, riscaldamento, stato, user_id) VALUES
('Bellissima Villa Milano Centro', 'Splendida villa in pieno centro a Milano con giardino e terrazza', 500000.00, 'Milano', 'MI', 'Via Montenapoleone', '10', 'VILLA', 250.0, 5, 3, 0, true, 'Autonomo', 'DISPONIBILE', 1),
('Appartamento Moderno Roma', 'Comodo appartamento in zona residenziale di Roma', 180000.00, 'Roma', 'RM', 'Via del Corso', '25', 'APPARTAMENTO', 90.0, 3, 1, 3, true, 'Centralizzato', 'DISPONIBILE', 2),
('Ampio Appartamento Torino', 'Appartamento ampio con balcone in torino centro', 220000.00, 'Torino', 'TO', 'Via Pietro Micca', '15', 'APPARTAMENTO', 120.0, 4, 2, 2, true, 'Autonomo', 'DISPONIBILE', 3),
('Casa Famiglia Firenze', 'Stupenda casa in zona tranquilla di Firenze', 320000.00, 'Firenze', 'FI', 'Via dei Servi', '8', 'CASA', 180.0, 4, 2, 0, false, 'Autonomo', 'DISPONIBILE', 2),
('Studio in centro Venezia', 'Caratteristico studio in palazzo storico a Venezia', 150000.00, 'Venezia', 'VE', 'Calle Larga San Marco', '5', 'APPARTAMENTO', 60.0, 1, 1, 1, false, 'Centralizzato', 'DISPONIBILE', 1),
('Terreno edificabile Bologna', 'Terreno con bellissima vista su Bologna', 85000.00, 'Bologna', 'BO', 'Via San Felice', '12', 'TERRENO', 500.0, 0, 0, 0, false, null, 'DISPONIBILE', 3),
('Attico Panoramico Napoli', 'Attico con terrazza panoramica su Napoli', 280000.00, 'Napoli', 'NA', 'Vomero', '42', 'VILLA', 200.0, 4, 3, 6, true, 'Autonomo', 'DISPONIBILE', 2),
('Bilocale Palermo Centro', 'Bilocale accogliente nel centro storico di Palermo', 95000.00, 'Palermo', 'PA', 'Via Maqueda', '30', 'APPARTAMENTO', 75.0, 2, 1, 2, false, 'Centralizzato', 'DISPONIBILE', 3);

