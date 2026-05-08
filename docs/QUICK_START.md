# ⚡ Quick Start Guide

## Setup in 5 minuti

### 1️⃣ Installare PostgreSQL

**macOS (con Homebrew):**
```bash
brew install postgresql@14
brew services start postgresql@14
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get install postgresql postgresql-contrib
sudo service postgresql start
```

**Windows:**
Scarica da https://www.postgresql.org/download/windows/

---

### 2️⃣ Creare Database

```bash
# Accedere a PostgreSQL
psql -U postgres

# Eseguire nel prompt PostgreSQL:
CREATE DATABASE agenzia_immobiliare;
CREATE USER agenzia_user WITH PASSWORD 'agenzia_pass123';
GRANT ALL PRIVILEGES ON DATABASE agenzia_immobiliare TO agenzia_user;
\q
```

---

### 3️⃣ Avviare Backend

```bash
cd backend

# Build (prima volta)
mvn clean install

# Run
mvn spring-boot:run
```

✅ Backend pronto a **http://localhost:8080/api**

---

### 4️⃣ Avviare Frontend

```bash
cd frontend

# Installare dipendenze (prima volta)
npm install

# Run dev server
npm run dev
```

✅ Frontend pronto a **http://localhost:5173**

---

### 5️⃣ Login e Test

Accedi con credenziali di test:
- **Email:** `admin@agenzia.it`
- **Password:** `password123`

Clicca "Area Dipendenti" nella home

---

## 🎯 Cosa puoi fare adesso

**Come visitatore:**
- ✅ Visualizzare annunci sulla home
- ✅ Ricercare per città, tipo, prezzo
- ✅ Vedere dettagli immobile

**Come dipendente (dopo login):**
- ✅ Creare nuovo annuncio
- ✅ Modificare annunzio
- ✅ Eliminare annuncio
- ✅ Visualizzare i tuoi annunci

---

## 🐛 Troubleshooting

### Backend non si avvia
```bash
# Controllare se PostgreSQL è avviato
psql -U postgres -d agenzia_immobiliare

# Se errore di connessione:
# Controllare application.yml - verificare user/password
```

### Frontend non si avvia
```bash
# Pulire cache e node_modules
rm -rf node_modules package-lock.json
npm install
npm run dev
```

### CORS errors
- Backend e frontend devono essere su porte diverse
- Backend default: 8080
- Frontend default: 5173
- ✅ Già configurato in SecurityConfig.java

### Token scaduto
- Token JWT expire dopo 24 ore
- Quando scade: logout automatico, torna a home
- Fare login di nuovo

---

## 📁 File Importanti

| File | Descrizione |
|------|-------------|
| `backend/pom.xml` | Dipendenze Maven |
| `backend/src/main/resources/application.yml` | Config backend |
| `backend/src/main/resources/db/migration/` | SQL migrations |
| `frontend/package.json` | Dipendenze Node |
| `frontend/vite.config.js` | Config Vite |
| `frontend/tailwind.config.js` | Config Tailwind CSS |

---

## 🚀 Deploy

### Build per produzione

**Backend:**
```bash
cd backend
mvn clean package
# JAR in: target/agenzia-backend-1.0.0.jar
```

**Frontend:**
```bash
cd frontend
npm run build
# Build in: dist/
```

---

## 📚 Documentazione Completa

- API Endpoints: Vedi `docs/API.md`
- README Completo: Vedi `README.md`
- Struttura Progetto: Vedi `README.md`

---

## 💡 Prossime Funzionalità

Pronti da implementare:
- [ ] Upload foto
- [ ] Form contatti
- [ ] Email notifications
- [ ] Admin dashboard
- [ ] Google OAuth
- [ ] Docker deployment

---

**Pronto? Inizia ad aggiungere annunci! 🎉**

