# 🚀 Deployment Guide

Guida completa al deployment dell'agenzia immobiliare su server di produzione.

## 📋 Indice

1. [Local Development](#local-development)
2. [Docker Deployment](#docker-deployment)
3. [Production Setup](#production-setup)
4. [Environment Variables](#environment-variables)
5. [Database Backup](#database-backup)
6. [Troubleshooting](#troubleshooting)

---

## Local Development

### Con Docker Compose (Recommended)

```bash
# Avviare tutto
docker-compose up -d

# Verificare che i servizi siano avviati
docker-compose ps

# Visualizzare log
docker-compose logs -f backend
docker-compose logs -f frontend

# Fermare tutto
docker-compose down
```

### Senza Docker

Vedi `docs/QUICK_START.md`

---

## Docker Deployment

### Prerequisiti

- Docker 20.10+
- Docker Compose 1.29+

### Build Immagini

```bash
# Build backend
docker build -t agenzia-backend:latest ./backend

# Build frontend
docker build -t agenzia-frontend:latest ./frontend

# Push su registry (opzionale)
docker tag agenzia-backend:latest your-registry/agenzia-backend:latest
docker push your-registry/agenzia-backend:latest
```

### Deploy con Docker Compose

```bash
# Start services
docker-compose up -d

# View status
docker-compose ps

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Stop and remove volumes (attenzione: elimina dati!)
docker-compose down -v
```

---

## Production Setup

### Variabili di Ambiente Essenziali

Crea `.env` nella root del progetto:

```bash
# Database
POSTGRES_DB=agenzia_immobiliare
POSTGRES_USER=agenzia_user
POSTGRES_PASSWORD=<strong-password>

# Backend
JWT_SECRET=<generate-with: openssl rand -hex 32>
SPRING_PROFILES_ACTIVE=production

# Frontend
VITE_API_BASE_URL=https://api.agenzia.it
```

### Generar JWT Secret Sicuro

```bash
openssl rand -hex 32
# Output: a3f8c92e1b4d7a9c6e2f5b8d1a4c7e9f2b5d8a1c4e7f0a3c6e9f2b5d8a1c4
```

### SSL/TLS Certificate

**Con Let's Encrypt (Recommended):**

```bash
# Installare Certbot
sudo apt-get install certbot python3-certbot-nginx

# Ottenere certificato
sudo certbot certonly --standalone -d api.agenzia.it -d agenzia.it

# Auto-renew (cron job)
0 0 1 * * certbot renew --quiet
```

### Nginx Reverse Proxy

```nginx
# /etc/nginx/sites-available/agenzia

# Frontend
server {
    listen 443 ssl http2;
    server_name agenzia.it www.agenzia.it;

    ssl_certificate /etc/letsencrypt/live/agenzia.it/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/agenzia.it/privkey.pem;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

# Backend API
server {
    listen 443 ssl http2;
    server_name api.agenzia.it;

    ssl_certificate /etc/letsencrypt/live/api.agenzia.it/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/api.agenzia.it/privkey.pem;

    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# HTTP to HTTPS redirect
server {
    listen 80;
    server_name agenzia.it api.agenzia.it;
    return 301 https://$server_name$request_uri;
}
```

### PostgreSQL Backup & Restore

```bash
# Backup automatico (cron giornaliero)
0 2 * * * pg_dump -U agenzia_user agenzia_immobiliare > /backups/agenzia_$(date +\%Y\%m\%d).sql

# Backup manuale
pg_dump -U agenzia_user -h localhost agenzia_immobiliare > backup.sql

# Restore
psql -U agenzia_user -h localhost agenzia_immobiliare < backup.sql
```

### Systemd Services (Optional)

```bash
# /etc/systemd/system/agenzia-backend.service
[Unit]
Description=Agenzia Immobiliare Backend
After=network.target

[Service]
Type=simple
User=agenzia
WorkingDirectory=/opt/agenzia/backend
ExecStart=java -jar /opt/agenzia/backend/agenzia-backend-1.0.0.jar
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target

# Abilitare servizio
sudo systemctl daemon-reload
sudo systemctl enable agenzia-backend
sudo systemctl start agenzia-backend
sudo systemctl status agenzia-backend
```

---

## Environment Variables

### Backend (.env)

```bash
# Database
SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/agenzia_immobiliare
SPRING_DATASOURCE_USERNAME=agenzia_user
SPRING_DATASOURCE_PASSWORD=<password>

# Server
SERVER_PORT=8080
SERVER_SERVLET_CONTEXT_PATH=/api

# JWT
JWT_SECRET=<your-256-bit-secret>
JWT_EXPIRATION=86400000

# Spring Profiles
SPRING_PROFILES_ACTIVE=production

# Logging
LOGGING_LEVEL_ROOT=INFO
LOGGING_LEVEL_IT_POLIMI_AGENZIA=INFO
```

### Frontend (.env)

```bash
VITE_API_BASE_URL=https://api.agenzia.it
VITE_API_TIMEOUT=30000
```

---

## Health Checks

### Backend Health

```bash
curl http://localhost:8080/api/health
```

### Database Connection

```bash
psql -U agenzia_user -h localhost -d agenzia_immobiliare -c "SELECT 1;"
```

### Frontend Status

```bash
curl http://localhost:3000
```

---

## Monitoring

### Logs

```bash
# Backend
docker logs -f agenzia_backend

# Frontend
docker logs -f agenzia_frontend

# Database
docker logs -f agenzia_postgres
```

### Disk Space

```bash
df -h
du -sh /var/lib/docker/volumes/
```

---

## Database Backup

### Backup Schedule

```bash
# Backup ogni notte alle 2 AM
0 2 * * * backup-agenzia.sh

# Retention: 30 giorni
find /backups -name "agenzia_*.sql" -mtime +30 -delete
```

### Script di Backup

```bash
#!/bin/bash
# backup-agenzia.sh

BACKUP_DIR="/backups"
DB_NAME="agenzia_immobiliare"
DB_USER="agenzia_user"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

pg_dump -U $DB_USER -h localhost $DB_NAME > \
  $BACKUP_DIR/agenzia_$TIMESTAMP.sql

gzip $BACKUP_DIR/agenzia_$TIMESTAMP.sql

echo "Backup completato: agenzia_$TIMESTAMP.sql.gz"
```

---

## Troubleshooting

### Backend non si connette al database

```bash
# Verificare che PostgreSQL sia avviato
docker ps | grep postgres

# Testare connessione
psql -U agenzia_user -h localhost -d agenzia_immobiliare

# Verificare variabili ambiente
echo $SPRING_DATASOURCE_URL
```

### Frontend errori CORS

```bash
# Verificare che backend sia raggiungibile
curl http://localhost:8080/api

# Controllare CORS in SecurityConfig.java
# Deve includere il dominio del frontend
```

### Memory Issues

```bash
# Aumentare heap Java
export JAVA_OPTS="-Xmx2g -Xms1g"

# Oppure in docker-compose.yml
environment:
  JAVA_OPTS: "-Xmx2g -Xms1g"
```

### Database disk space full

```bash
# Verificare size database
du -sh /var/lib/docker/volumes/agenzia_postgres_data/

# Vaccuum database
vacuumdb -U agenzia_user -h localhost agenzia_immobiliare

# Se troppo pieno, eliminare backup vecchi
find /backups -mtime +60 -delete
```

---

## Ci sono domande?

Per supporto: support@agenzia.it

