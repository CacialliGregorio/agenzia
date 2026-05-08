# 🗺️ Roadmap del Progetto

Sviluppo incrementale dell'agenzia immobiliare.

---

## ✅ MVP - Phase 1 (COMPLETATO)

- ✅ Vetrina pubblica annunci
- ✅ Ricerca e filtri
- ✅ Dettagli immobile
- ✅ Autenticazione JWT
- ✅ Area dipendenti (CRUD)
- ✅ Database con Flyway
- ✅ API REST completa

**Timeline:** 1-2 settimane

---

## 🔄 Phase 2 - Photo Gallery (Prossimo)

**Timeline:** Settimana 3

### Backend
- [ ] Entity `Foto` con relazione `Immobile`
- [ ] Upload file endpoint
- [ ] Delete foto endpoint
- [ ] Image resizing (thumbnails)
- [ ] File storage locale o S3

### Frontend
- [ ] Galleria foto immobile
- [ ] Drag & drop upload
- [ ] Image preview
- [ ] Lightbox viewer
- [ ] Progressivo loading

### Database
- [ ] Migration per `foto` table (già creata!)
- [ ] Indice su `immobile_id`

---

## 📧 Phase 3 - Email & Notifications

**Timeline:** Settimana 4

### Backend
- [ ] EmailService con JavaMailSender
- [ ] Template email (Thymeleaf)
- [ ] Scheduled tasks (quartz)
- [ ] Email queue (optional)

### Features
- [ ] Conferma registrazione
- [ ] Password reset
- [ ] Notifiche nuovo annuncio
- [ ] Alert quando immobile venduto
- [ ] Newsletter settimanale

---

## 👤 Phase 4 - User Management

**Timeline:** Settimana 5-6

### Backend
- [ ] Registrazione utenti dipendenti
- [ ] Role-based permissions (ADMIN, EMPLOYEE, CLIENT)
- [ ] User management endpoint (ADMIN only)
- [ ] Activity logs

### Frontend
- [ ] Admin panel users
- [ ] User creation form
- [ ] Permission management UI
- [ ] Audit log viewer

---

## 💬 Phase 5 - Contact & Messaging

**Timeline:** Settimana 7

### Backend
- [ ] Contact form submission
- [ ] Message storage
- [ ] Private messaging between users
- [ ] Notification system

### Frontend
- [ ] Contact form component
- [ ] Messaging interface
- [ ] Notification bell
- [ ] Message threads

---

## ⭐ Phase 6 - Wishlist & Favorites

**Timeline:** Settimana 8

### Backend
- [ ] Entity `Preferiti`
- [ ] Add/remove favorite endpoints
- [ ] Get user favorites

### Frontend
- [ ] Heart button su annunci
- [ ] Favorites page
- [ ] Share favoriti

---

## 🔍 Phase 7 - Advanced Search

**Timeline:** Settimana 9

### Backend
- [ ] Full-text search
- [ ] Elasticsearch integration (optional)
- [ ] Saved searches
- [ ] Search history

### Frontend
- [ ] Advanced filter UI
- [ ] Map view
- [ ] Price chart
- [ ] Saved searches

---

## 🔐 Phase 8 - Authentication Enhanced

**Timeline:** Settimana 10-11

### Features
- [ ] Google OAuth 2.0 login
- [ ] GitHub OAuth 2.0 login
- [ ] 2FA (Two-Factor Authentication)
- [ ] Social login
- [ ] Remember me

---

## 📊 Phase 9 - Admin Dashboard

**Timeline:** Settimana 12-13

### Backend
- [ ] Analytics endpoints
- [ ] Statistics (immobili, visits, etc.)
- [ ] Reports generation

### Frontend
- [ ] Dashboard charts (Chart.js/Recharts)
- [ ] Statistics tiles
- [ ] User analytics
- [ ] Sales reports
- [ ] Export CSV/PDF

---

## 🎨 Phase 10 - UI/UX Improvements

**Timeline:** Settimana 14

- [ ] Design system consistency
- [ ] Animations & transitions
- [ ] Dark mode support
- [ ] Mobile app version (React Native)
- [ ] Accessibility (WCAG 2.1 AA)

---

## 🌍 Phase 11 - Internationalization

**Timeline:** Settimana 15

- [ ] i18n setup (i18next)
- [ ] Traduzioni IT, EN, FR, DE, ES
- [ ] Currency support (€, $, £)
- [ ] Date/time localization

---

## 📱 Phase 12 - Progressive Web App

**Timeline:** Settimana 16-17

- [ ] Service Worker
- [ ] Offline support
- [ ] Push notifications
- [ ] Install prompt
- [ ] PWA optimization

---

## 🚀 Phase 13 - Performance & Optimization

**Timeline:** Settimana 18

### Backend
- [ ] Query optimization
- [ ] Caching (Redis)
- [ ] Load balancing
- [ ] Database indexing

### Frontend
- [ ] Code splitting
- [ ] Lazy loading
- [ ] CDN integration
- [ ] Image optimization
- [ ] Bundle size reduction

---

## 📈 Phase 14 - Advanced Features

**Timeline:** Settimane 19+

- [ ] Virtual tours 360°
- [ ] AI-powered search
- [ ] Price prediction
- [ ] Market analytics
- [ ] Mortgage calculator
- [ ] Lead scoring
- [ ] CRM integration
- [ ] API marketplace

---

## 🎯 Priorità Immediate (Next 3 weeks)

1. **Phase 2 - Photo Gallery** ⭐⭐⭐
   - Users want to see lots of photos
   - Core feature for real estate

2. **Phase 3 - Email Notifications** ⭐⭐⭐
   - Improve user engagement
   - Essential for conversions

3. **Phase 4 - User Management** ⭐⭐
   - Scale team operations
   - Important for agencies

---

## 💡 Ideas Brainstorm

- [ ] Virtual site visits (Zoom integration)
- [ ] QR code per annunci
- [ ] WhatsApp bot integration
- [ ] SMS alerts
- [ ] Voice search
- [ ] Video tours auto-generated
- [ ] AI image enhancement
- [ ] Block chain property deeds
- [ ] Cryptocurrency payments
- [ ] Augmented Reality (AR) viewing

---

## 🐛 Known Issues / Tech Debt

- [ ] ImmobileRepository.cercaImmobili() needs better query optimization
- [ ] No error handling on file upload (Phase 2)
- [ ] No rate limiting on API
- [ ] JWT secret hardcoded in application.yml
- [ ] No input sanitization (XSS prevention)
- [ ] No SQL injection prevention (need parameterized queries - already done ✅)
- [ ] No logging strategy
- [ ] No monitoring/alerting

---

## 📞 Community Feedback Welcome!

Quali features sono più importanti per te?
- [ ] Foto/Galleria
- [ ] Notifiche email
- [ ] User dashboard
- [ ] Messaggistica
- [ ] Mobile app
- [ ] OAuth login
- [ ] Altro?

Commenta su GitHub Issues!

---

**Last Updated:** Gennaio 2024
**Versione:** 1.0.0

