# 📡 API Documentation

## Base URL
```
http://localhost:8080/api
```

## 🔐 Authentication

Tutte le richieste protette richiedono un header:
```
Authorization: Bearer <jwt_token>
```

---

## 🔓 Endpoints Pubblici

### Login
```http
POST /auth/login
Content-Type: application/json

{
  "email": "admin@agenzia.it",
  "password": "password123"
}

Response 200:
{
  "token": "eyJhbGciOiJIUzUxMiJ9...",
  "userId": 1,
  "email": "admin@agenzia.it",
  "nome": "Admin",
  "cognome": "Agenzia",
  "role": "ADMIN"
}
```

### Ottenere Immobili Disponibili
```http
GET /immobili?page=0&size=12

Response 200:
{
  "content": [
    {
      "id": 1,
      "titolo": "Bellissima Villa Milano Centro",
      "descrizione": "Splendida villa...",
      "prezzo": 500000.00,
      "citta": "Milano",
      "provincia": "MI",
      "tipo": "VILLA",
      "stato": "DISPONIBILE",
      "superficieMq": 250.0,
      "numeroLocali": 5,
      "numeroBagni": 3,
      "creatoIl": "2024-01-15T10:30:00"
    }
  ],
  "totalElements": 50,
  "totalPages": 5,
  "currentPage": 0
}
```

### Ricerca Immobili
```http
GET /immobili/cerca?citta=Milano&tipo=APPARTAMENTO&prezzoMin=100000&prezzoMax=500000&page=0&size=12

Query Parameters:
- citta (optional): string
- tipo (optional): CASA | APPARTAMENTO | VILLA | TERRENO | GARAGE | UFFICIO | NEGOZIO | MANSARDA
- stato (optional): DISPONIBILE | VENDUTO | AFFITTATO
- prezzoMin (optional): number (default: 0)
- prezzoMax (optional): number (default: 999999999)
- page (optional): number (default: 0)
- size (optional): number (default: 12)

Response 200: (come GET /immobili)
```

### Dettagli Immobile
```http
GET /immobili/{id}

Response 200:
{
  "id": 1,
  "titolo": "Bellissima Villa Milano Centro",
  "descrizione": "Splendida villa in pieno centro...",
  "prezzo": 500000.00,
  "citta": "Milano",
  "provincia": "MI",
  "via": "Via Montenapoleone",
  "numeroCivico": "10",
  "tipo": "VILLA",
  "superficieMq": 250.0,
  "numeroLocali": 5,
  "numeroBagni": 3,
  "piano": 0,
  "ascensore": true,
  "riscaldamento": "Autonomo",
  "stato": "DISPONIBILE",
  "userId": 1,
  "creatoIl": "2024-01-15T10:30:00",
  "aggiornatoIl": "2024-01-15T10:30:00"
}
```

---

## 🔒 Endpoints Protetti

Richiedono token JWT

### Creare Immobile
```http
POST /immobili
Content-Type: application/json
Authorization: Bearer <token>

{
  "titolo": "Nuovo Appartamento",
  "descrizione": "Comodo appartamento in zona centrale",
  "prezzo": 250000,
  "citta": "Roma",
  "provincia": "RM",
  "via": "Via del Corso",
  "numeroCivico": "50",
  "tipo": "APPARTAMENTO",
  "superficieMq": 120,
  "numeroLocali": 4,
  "numeroBagni": 2,
  "piano": 3,
  "ascensore": true,
  "riscaldamento": "Centralizzato"
}

Response 201:
{
  "id": 9,
  "titolo": "Nuovo Appartamento",
  ...
}

Response 400:
{
  "error": "Dati non validi"
}
```

### Modificare Immobile
```http
PUT /immobili/{id}
Content-Type: application/json
Authorization: Bearer <token>

{
  "titolo": "Appartamento Modificato",
  "prezzo": 280000,
  ...
}

Response 200:
{
  "id": 1,
  "titolo": "Appartamento Modificato",
  ...
}

Response 403:
{
  "error": "Non autorizzato"
}
```

### Eliminare Immobile
```http
DELETE /immobili/{id}
Authorization: Bearer <token>

Response 204: No Content

Response 403:
{
  "error": "Non autorizzato"
}

Response 404:
{
  "error": "Immobile non trovato"
}
```

---

## ⚠️ Codici di Risposta

| Codice | Significato |
|--------|-------------|
| 200 | OK |
| 201 | Creato |
| 204 | Nessun contenuto |
| 400 | Bad Request |
| 401 | Non autenticato |
| 403 | Non autorizzato |
| 404 | Non trovato |
| 500 | Errore server |

---

## 🧪 Testare con cURL

```bash
# Login
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@agenzia.it","password":"password123"}'

# Ottenere immobili
curl -X GET "http://localhost:8080/api/immobili?page=0&size=12"

# Ottenere immobile specifico
curl -X GET http://localhost:8080/api/immobili/1

# Creare immobile (con token)
curl -X POST http://localhost:8080/api/immobili \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <token>" \
  -d '{
    "titolo":"Nuovo Immobile",
    "prezzo":200000,
    "citta":"Napoli",
    "tipo":"APPARTAMENTO"
  }'
```

---

## 🔄 Autenticazione JWT

Il token JWT contiene:
- `subject`: email utente
- `userId`: ID utente
- `issuedAt`: timestamp creazione
- `expiration`: timestamp scadenza (24 ore)

Esempio payload decodificato:
```json
{
  "sub": "admin@agenzia.it",
  "userId": 1,
  "iat": 1705324200,
  "exp": 1705410600
}
```

---

## 📝 Validazioni

### Immobile
- `titolo`: required, max 255 caratteri
- `prezzo`: required, > 0
- `citta`: required, max 100 caratteri
- `tipo`: required, one of CASA, APPARTAMENTO, VILLA, TERRENO, GARAGE, UFFICIO, NEGOZIO, MANSARDA
- `numeroLocali`: optional, > 0
- `numeroBagni`: optional, > 0
- `superficieMq`: optional, > 0
- `piano`: optional

### Login
- `email`: required, formato email valido
- `password`: required, min 1 carattere

