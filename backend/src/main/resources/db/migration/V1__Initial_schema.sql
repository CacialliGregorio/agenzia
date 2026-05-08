-- V1__Initial_schema.sql

-- Create USERS table
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    creato_il TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    aggiornato_il TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);

-- Create IMMOBILI table
CREATE TABLE immobili (
    id BIGSERIAL PRIMARY KEY,
    titolo VARCHAR(255) NOT NULL,
    descrizione TEXT,
    prezzo NUMERIC(15,2) NOT NULL,
    citta VARCHAR(100) NOT NULL,
    provincia VARCHAR(100),
    via VARCHAR(255),
    numero_civico VARCHAR(10),
    tipo VARCHAR(50) NOT NULL,
    superficie_mq DOUBLE PRECISION,
    numero_locali INTEGER,
    numero_bagni INTEGER,
    piano INTEGER,
    ascensore BOOLEAN,
    riscaldamento VARCHAR(100),
    stato VARCHAR(50) NOT NULL,
    user_id BIGINT NOT NULL,
    creato_il TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    aggiornato_il TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX idx_immobili_citta ON immobili(citta);
CREATE INDEX idx_immobili_stato ON immobili(stato);
CREATE INDEX idx_immobili_user_id ON immobili(user_id);
CREATE INDEX idx_immobili_prezzo ON immobili(prezzo);

-- Create FOTO table
CREATE TABLE foto (
    id BIGSERIAL PRIMARY KEY,
    immobile_id BIGINT NOT NULL,
    nome_file VARCHAR(255) NOT NULL,
    percorso VARCHAR(500) NOT NULL,
    ordinamento INTEGER,
    creato_il TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (immobile_id) REFERENCES immobili(id) ON DELETE CASCADE
);

CREATE INDEX idx_foto_immobile_id ON foto(immobile_id);

