# 🏠 Agenzia Immobiliare - Portale Web

Portale web moderno per un'agenzia immobiliare con vetrina pubblica e area dipendenti riservata.

## 🚀 Stack Tecnologico

**Backend:**
- Java 17
- Spring Boot 3.2
- Spring Security + JWT
- Spring Data JPA
- PostgreSQL
- Flyway (Database Migrations)
- Maven

**Frontend:**
- React 18
- React Router v6
- Tailwind CSS
- Axios
- Vite

## 📋 Prerequisiti

- Java 17+
- Node.js 18+
- PostgreSQL 14+
- Maven 3.8+
- Git

## 🔧 Setup Backend

### 1. Configurare PostgreSQL

```bash
# Creare database e utente
createdb agenzia_immobiliare
createuser agenzia_user -P
# Password: agenzia_pass123

# Assegnare privilegi
psql -U postgres
GRANT ALL PRIVILEGES ON DATABASE agenzia_immobiliare TO agenzia_user;
\q
```

### 2. Build e Run

```bash
cd backend

# Build
mvn clean install

# Run
mvn spring-boot:run
```

Il backend sarà disponibile a: **http://localhost:8080/api**

### 3. Credenziali di Test

```
Email: admin@agenzia.it
Password: password123

Email: dipendente1@agenzia.it
Password: password123
```

## 🎨 Setup Frontend

### 1. Installare dipendenze

```bash
cd frontend
npm install
```

### 2. Avviare il dev server

```bash
npm run dev
```

Frontend disponibile a: **http://localhost:5173**

### 3. Build per produzione

```bash
npm run build
```

## 📚 API Endpoints Principali

### Autenticazione
- `POST /auth/login` - Login utente

### Immobili (Pubblico)
- `GET /immobili` - Lista immobili disponibili (paginated)
- `GET /immobili/{id}` - Dettagli immobile
- `GET /immobili/cerca` - Ricerca con filtri

### Immobili (Protetto - Solo Dipendenti)
- `POST /immobili` - Creare nuovo annuncio
- `PUT /immobili/{id}` - Modificare annuncio
- `DELETE /immobili/{id}` - Eliminare annuncio

## 🗂️ Struttura Progetto

```
agenzia/
├── backend/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/it/polimi/agenzia/
│   │   │   │   ├── controller/
│   │   │   │   ├── service/
│   │   │   │   ├── entity/
│   │   │   │   ├── repository/
│   │   │   │   ├── dto/
│   │   │   │   ├── security/
│   │   │   │   ├── config/
│   │   │   │   └── AgenziaApplication.java
│   │   │   └── resources/
│   │   │       ├── application.yml
│   │   │       └── db/migration/
│   │   └── test/
│   └── pom.xml
│
├── frontend/
│   ├── src/
│   │   ├── pages/
│   │   │   ├── Home.jsx
│   │   │   ├── LoginPage.jsx
│   │   │   ├── ImmobileDetail.jsx
│   │   │   └── Dashboard.jsx
│   │   ├── components/
│   │   │   └── ImmobileForm.jsx
│   │   ├── api/
│   │   │   └── axiosInstance.js
│   │   ├── App.jsx
│   │   ├── main.jsx
│   │   └── index.css
│   ├── index.html
│   ├── vite.config.js
│   ├── tailwind.config.js
│   ├── postcss.config.js
│   └── package.json
│
└── README.md
```

## 📋 Funzionalità Implementate

✅ **Vetrina Pubblica**
- Lista annunci con paginazione
- Ricerca e filtri (città, tipo, prezzo)
- Dettagli immobile

✅ **Area Dipendenti**
- Login con JWT authentication
- Creare nuovi annunci
- Modificare annunci esistenti
- Eliminare annunci
- Dashboard con elenco annunci

✅ **Backend**
- API REST completa
- Autenticazione JWT
- Validazione dati
- Database con Flyway migrations

## 🚀 Prossimi Passi

- [ ] Upload foto annunci
- [ ] Galleria foto
- [ ] Form di contatto
- [ ] Email notifications
- [ ] Dashboard Admin avanzato
- [ ] Preferiti/Wishlist
- [ ] Messaggistica privata
- [ ] Google/GitHub OAuth login
- [ ] PWA (Progressive Web App)
- [ ] Docker deployment

## 🤝 Sviluppo

### Aggiungere nuovi campi al database

1. Creare una nuova migration in `backend/src/main/resources/db/migration/`
2. Aggiornare l'entity JPA
3. Aggiornare il DTO se necessario

Esempio:
```sql
-- V3__Add_new_field.sql
ALTER TABLE immobili ADD COLUMN nuovo_campo VARCHAR(255);
```

### Aggiungere nuove pagine React

1. Creare componente in `frontend/src/pages/`
2. Aggiungere rotta in `App.jsx`
3. Aggiungere link in navigazione

## 📝 Licenza

MIT License

## 📧 Supporto

Per problemi o domande, contatta: support@agenzia.it

