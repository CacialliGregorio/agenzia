CREATE TABLE IF NOT EXISTS recensioni (
                                          id BIGSERIAL PRIMARY KEY,
                                          voto INTEGER NOT NULL CHECK (voto >= 1 AND voto <= 5),
    testo TEXT NOT NULL,
    creato_il TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);