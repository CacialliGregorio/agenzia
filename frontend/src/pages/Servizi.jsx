import { Link } from 'react-router-dom'
import {
  LogIn,
  Briefcase,
  Facebook,
  Instagram,
  Phone,
  Mail,
  Smartphone,
  MapPinned,
} from 'lucide-react'
import WhatsAppTopLink from '../components/WhatsAppTopLink'
export default function Servizi() {
  const token = localStorage.getItem('token')

  return (
      <div className="min-h-screen bg-gray-50">
        {/* Top Bar */}
        <div className="bg-gray-900 text-white text-sm py-2">
          <div className="max-w-7xl mx-auto px-4 flex justify-between items-center">
            <div className="flex gap-4 items-center">
              <WhatsAppTopLink />

              <a
                  href="https://www.facebook.com/ILMONDOIMMOBILIARECR"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="bg-white rounded-lg p-1.5 flex items-center justify-center hover:bg-blue-100 transition"
              >
                <Facebook className="w-5 h-5 text-blue-600" />
              </a>

              <a
                  href="https://www.instagram.com/ilmondoimmobiliare/"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="bg-white rounded-lg p-1.5 flex items-center justify-center hover:bg-pink-100 transition"
              >
                <Instagram className="w-5 h-5 text-pink-500" />
              </a>

              <span className="mx-2 h-5 w-px bg-gray-400 inline-block"></span>

              <a href="tel:03723397" className="hover:text-gray-300">
                📞 0372 32397
              </a>

              <a
                  href="mailto:agenzia@ilmondoimmobiliare.eu"
                  className="hover:text-gray-300"
              >
                ✉️ agenzia@ilmondoimmobiliare.eu
              </a>
            </div>

            <div className="flex gap-4">
              {token ? (
                  <Link to="/dashboard" className="hover:text-gray-300">
                    Dashboard
                  </Link>
              ) : (
                  <Link
                      to="/login"
                      className="hover:text-gray-300 flex items-center gap-1"
                  >
                    <LogIn className="w-4 h-4" />
                    Area Dipendenti
                  </Link>
              )}
            </div>
          </div>
        </div>

        {/* Header */}
        <header className="bg-white shadow-sm sticky top-0 z-20">
          <div className="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
            <div className="flex items-center gap-2">
              <button
                  type="button"
                  onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}
                  className="cursor-pointer"
                  aria-label="Torna in cima alla pagina"
              >
                <img
                    src="/logo.jpeg"
                    alt="Il Mondo Immobiliare"
                    className="h-16 w-auto"
                />
              </button>
            </div>

            <nav className="flex gap-6">
              <Link
                  to="/"
                  className="text-gray-700 hover:text-blue-600 font-medium"
              >
                Home
              </Link>

              <Link
                  to="/immobili"
                  className="text-gray-700 hover:text-blue-600 font-medium"
              >
                Immobili
              </Link>

              <Link
                  to="/contatti"
                  className="text-gray-700 hover:text-blue-600 font-medium"
              >
                Contatti
              </Link>

              <Link to="/servizi" className="text-blue-600 font-medium">
                Servizi
              </Link>

              <Link
                  to="/agenzia"
                  className="text-gray-700 hover:text-blue-600 font-medium"
              >
                Agenzia
              </Link>
              <Link
                  to="/recensioni"
                  className="text-gray-700 hover:text-blue-600 font-medium"
              >
                Recensioni
              </Link>
            </nav>
          </div>
        </header>

        {/* Main Content */}
        <main className="max-w-7xl mx-auto px-4 py-12">
          <h1 className="text-4xl font-bold text-gray-800 mb-8">
            I Nostri Servizi
          </h1>

          {/* Tre box servizi */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
            <div className="bg-white p-6 rounded-lg shadow hover:shadow-lg transition">
              <Briefcase className="w-8 h-8 text-blue-600 mb-3" />

              <h3 className="text-lg font-bold mb-2">Vendita Immobili</h3>

              <p className="text-gray-600 leading-7">
                Assistenza completa nella compravendita di proprietà.
              </p>
            </div>

            <div className="bg-white p-6 rounded-lg shadow hover:shadow-lg transition">
              <Briefcase className="w-8 h-8 text-blue-600 mb-3" />

              <h3 className="text-lg font-bold mb-2">Affitti</h3>

              <p className="text-gray-600 leading-7">
                Gestione e ricerca di soluzioni abitative in affitto.
              </p>
            </div>

            <div className="bg-white p-6 rounded-lg shadow hover:shadow-lg transition">
              <Briefcase className="w-8 h-8 text-blue-600 mb-3" />

              <h3 className="text-lg font-bold mb-2">Consulenza</h3>

              <p className="text-gray-600 leading-7">
                Consulenza specializzata nel settore immobiliare.
              </p>
            </div>
          </div>

          {/* Testo descrittivo come nello screenshot originale */}
          <section className="bg-gray-50 px-4 py-12 mb-12">
            <div className="max-w-6xl mx-auto text-center">
              <p className="text-2xl md:text-3xl text-gray-600 leading-relaxed mb-8">
                L’agenzia{' '}
                <strong className="font-bold text-gray-700">
                  “Il Mondo Immobiliare”
                </strong>{' '}
                offre alla propria clientela un insieme di servizi integrati in
                grado di soddisfare tutte le esigenze di chi compra, vende, affitta
                o ricerca un immobile.
              </p>

              <p className="text-2xl md:text-3xl text-gray-600 leading-relaxed mb-12">
                La professionalità del proprio staff consente di risolvere con
                efficienza e tempestività tutte le pratiche burocratiche e gli
                adempimenti fiscali connessi come:
              </p>

              <div className="max-w-2xl mx-auto text-left border-l-4 border-gray-200 pl-8">
                <ul className="text-xl text-gray-600 leading-10">
                  <li>- stipula e la registrazione di contratti;</li>
                  <li>- risoluzioni contratti</li>
                  <li>- valutazioni e perizie;</li>
                  <li>- assistenza fiscale e finanziaria;</li>
                  <li>- ricerca clienti;</li>
                  <li>- certificazioni energetiche</li>
                </ul>
              </div>
            </div>
          </section>
        </main>

        {/* Footer verde con contatti */}
        <section className="bg-green-500 text-white">
          <div className="max-w-7xl mx-auto px-4 py-14">
            <div className="grid grid-cols-1 gap-10 md:grid-cols-3">
              {/* Colonna descrizione */}
              <div>
                <h2 className="text-2xl font-bold mb-6">
                  Il Mondo Immobiliare
                </h2>

                <p className="text-lg leading-8">
                  L'agenzia “Il Mondo Immobiliare” offre alla propria clientela un
                  insieme di servizi integrati in grado di soddisfare tutte le
                  esigenze di chi compra, vende, affitta o ricerca un immobile.
                </p>
              </div>

              {/* Colonna FIMAA */}
              <div className="text-center">
                <h2 className="text-2xl font-bold mb-6">F.I.M.A.A.</h2>

                <img
                    src="/fimaa.jpg"
                    alt="F.I.M.A.A."
                    className="mx-auto max-h-32 w-auto bg-white p-2 rounded"
                />
              </div>

              {/* Colonna contatti */}
              <div>
                <h2 className="text-2xl font-bold mb-6">Contatti</h2>

                <div className="space-y-3">
                  <a
                      href="https://www.google.com/maps/search/?api=1&query=Viale+Trento+e+Trieste+120+Cremona"
                      target="_blank"
                      rel="noopener noreferrer"
                      className="flex items-center bg-green-700/60 hover:bg-green-800/80 transition rounded px-4 py-3"
                  >
                  <span className="w-10 h-10 bg-green-800/80 rounded flex items-center justify-center mr-3">
                    <MapPinned className="w-5 h-5 text-white" />
                  </span>

                    <span className="font-semibold">
                    Viale Trento e Trieste, 120
                  </span>
                  </a>

                  <a
                      href="tel:+39037232397"
                      className="flex items-center bg-green-700/60 hover:bg-green-800/80 transition rounded px-4 py-3"
                  >
                  <span className="w-10 h-10 bg-green-800/80 rounded flex items-center justify-center mr-3">
                    <Phone className="w-5 h-5 text-white" />
                  </span>

                    <span className="font-semibold">(+39) 0372 32397</span>
                  </a>

                  <a
                      href="tel:+393784305750"
                      className="flex items-center bg-green-700/60 hover:bg-green-800/80 transition rounded px-4 py-3"
                  >
                  <span className="w-10 h-10 bg-green-800/80 rounded flex items-center justify-center mr-3">
                    <Smartphone className="w-5 h-5 text-white" />
                  </span>

                    <span className="font-semibold">(+39) 378 4305750</span>
                  </a>

                  <a
                      href="mailto:agenzia@ilmondoimmobiliare.eu"
                      className="flex items-center bg-green-700/60 hover:bg-green-800/80 transition rounded px-4 py-3"
                  >
                  <span className="w-10 h-10 bg-green-800/80 rounded flex items-center justify-center mr-3">
                    <Mail className="w-5 h-5 text-white" />
                  </span>

                    <span className="font-semibold break-all">
                    agenzia@ilmondoimmobiliare.eu
                  </span>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Barra finale come sito originale */}
        <footer className="bg-green-900 text-white">
          <div className="max-w-7xl mx-auto px-4 py-8">
            <div className="flex flex-col md:flex-row items-center md:items-start justify-between gap-8">
              <div className="flex flex-col items-start gap-1">
                <a
                    href="https://www.iubenda.com/privacy-policy/51205261"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center gap-1 bg-white text-gray-700 text-xs font-semibold px-2 py-1 rounded shadow hover:bg-gray-100 transition"
                >
                    <span className="inline-flex items-center justify-center w-3 h-3 bg-green-500 text-white rounded-sm text-[9px]">
                     i
                    </span>
                  Privacy Policy
                </a>

                <a
                    href="https://www.iubenda.com/privacy-policy/51205261/cookie-policy"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="inline-flex items-center gap-1 bg-white text-gray-700 text-xs font-semibold px-2 py-1 rounded shadow hover:bg-gray-100 transition"
                >
                    <span className="inline-flex items-center justify-center w-3 h-3 bg-green-500 text-white rounded-sm text-[9px]">
                       i
                    </span>
                  Cookie Policy
                </a>
              </div>

              {/* Logo grande a destra */}
              <div className="w-full md:w-1/2 flex justify-center md:justify-end">
                <img
                    src="/logo.jpeg"
                    alt="Il Mondo Immobiliare"
                    className="h-20 w-auto"
                />
              </div>
            </div>
          </div>
        </footer>
      </div>
  )
}