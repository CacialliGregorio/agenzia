import { useState } from 'react'
import { Link } from 'react-router-dom'
import {
  LogIn,
  Phone,
  Mail,
  MapPin,
  Facebook,
  Instagram,
  Smartphone,
  MapPinned,
  Send,
} from 'lucide-react'
import WhatsAppTopLink from '../components/WhatsAppTopLink'
export default function Contatti() {
  const token = localStorage.getItem('token')

  const [formData, setFormData] = useState({
    nome: '',
    email: '',
    oggetto: '',
    messaggio: '',
    privacy: false,
  })

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target

    setFormData({
      ...formData,
      [name]: type === 'checkbox' ? checked : value,
    })
  }

  const inviaWhatsapp = (e) => {
    e.preventDefault()

    if (!formData.nome.trim()) {
      alert('Inserisci il nome')
      return
    }

    if (!formData.email.trim()) {
      alert("Inserisci l'email")
      return
    }

    if (!formData.messaggio.trim()) {
      alert('Inserisci il messaggio')
      return
    }

    if (!formData.privacy) {
      alert('Devi accettare la privacy policy per inviare il messaggio')
      return
    }

    const testo = `
Richiesta dal sito Il Mondo Immobiliare

Nome: ${formData.nome}
Email: ${formData.email}
Oggetto: ${formData.oggetto || 'Nessun oggetto'}

Messaggio:
${formData.messaggio}
`

    const numeroWhatsapp = '393294011384'
    const linkWhatsapp = `https://wa.me/${numeroWhatsapp}?text=${encodeURIComponent(
        testo
    )}`

    window.open(linkWhatsapp, '_blank')
  }

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
              <img src="/logo.jpeg" alt="Agenzia Logo" className="h-12 w-auto" />
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

              <Link to="/contatti" className="text-blue-600 font-medium">
                Contatti
              </Link>

              <Link
                  to="/servizi"
                  className="text-gray-700 hover:text-blue-600 font-medium"
              >
                Servizi
              </Link>

              <Link
                  to="/agenzia"
                  className="text-gray-700 hover:text-blue-600 font-medium"
              >
                Agenzia
              </Link>
            </nav>
          </div>
        </header>

        {/* Main Content */}
        <main className="max-w-7xl mx-auto px-4 py-12">
          <h1 className="text-4xl font-bold text-gray-800 mb-8">Contatti</h1>

          {/* Riquadri contatti */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
            <div className="bg-white p-6 rounded-lg shadow">
              <Phone className="w-8 h-8 text-blue-600 mb-3" />

              <h3 className="text-lg font-bold mb-2">Telefono</h3>

              <a href="tel:03723397" className="text-blue-600 hover:underline">
                0372 32397
              </a>
            </div>

            <div className="bg-white p-6 rounded-lg shadow">
              <Mail className="w-8 h-8 text-blue-600 mb-3" />

              <h3 className="text-lg font-bold mb-2">Email</h3>

              <a
                  href="mailto:agenzia@ilmondoimmobiliare.eu"
                  className="text-blue-600 hover:underline break-all"
              >
                agenzia@ilmondoimmobiliare.eu
              </a>
            </div>

            <div className="bg-white p-6 rounded-lg shadow">
              <MapPin className="w-8 h-8 text-blue-600 mb-3" />

              <h3 className="text-lg font-bold mb-2">Ubicazione</h3>

              <a
                  href="https://www.google.com/maps/search/?api=1&query=Viale+Trento+e+Trieste+120+Cremona"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-blue-600 hover:underline"
              >
                Viale Trento e Trieste, 120
                <br />
                26100 Cremona
              </a>
            </div>
          </div>

          {/* Mappa + form WhatsApp */}
          <section className="bg-white rounded-xl shadow-lg overflow-hidden mb-12">
            <div className="grid grid-cols-1 lg:grid-cols-2">
              {/* Mappa */}
              <div className="min-h-[520px]">
                <iframe
                    title="Mappa Il Mondo Immobiliare"
                    src="https://www.google.com/maps?q=Viale%20Trento%20e%20Trieste%20120%20Cremona&output=embed"
                    className="w-full h-full min-h-[520px] border-0"
                    loading="lazy"
                    referrerPolicy="no-referrer-when-downgrade"
                ></iframe>
              </div>

              {/* Form */}
              <div className="p-8 lg:p-10">
                <h2 className="text-4xl font-light text-gray-900 mb-5">
                  Mandaci un messaggio
                </h2>

                <p className="text-xl text-gray-600 leading-8 mb-8">
                  Per maggiori informazioni, usa il modulo sottostante per
                  lasciarci domande o richieste di informazione. Ti risponderemo
                  al più presto tramite WhatsApp.
                </p>

                <form onSubmit={inviaWhatsapp} className="space-y-5">
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
                    <input
                        type="text"
                        name="nome"
                        value={formData.nome}
                        onChange={handleChange}
                        placeholder="Nome*"
                        className="w-full px-5 py-4 border border-gray-300 rounded text-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                    />

                    <input
                        type="email"
                        name="email"
                        value={formData.email}
                        onChange={handleChange}
                        placeholder="Email*"
                        className="w-full px-5 py-4 border border-gray-300 rounded text-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                    />
                  </div>

                  <input
                      type="text"
                      name="oggetto"
                      value={formData.oggetto}
                      onChange={handleChange}
                      placeholder="Oggetto"
                      className="w-full px-5 py-4 border border-gray-300 rounded text-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                  />

                  <textarea
                      name="messaggio"
                      value={formData.messaggio}
                      onChange={handleChange}
                      placeholder="Messaggio"
                      rows="7"
                      className="w-full px-5 py-4 border border-gray-300 rounded text-lg resize-none focus:outline-none focus:ring-2 focus:ring-green-500"
                  />

                  <label className="flex items-start gap-3 text-gray-600 text-lg leading-7 border border-gray-300 rounded px-4 py-4">
                    <input
                        type="checkbox"
                        name="privacy"
                        checked={formData.privacy}
                        onChange={handleChange}
                        className="mt-1 w-5 h-5"
                    />

                    <span>
                    Sì, inviando questo messaggio accetto la privacy policy del
                    sito web sul trattamento dei miei dati personali.
                  </span>
                  </label>

                  <button
                      type="submit"
                      className="w-full bg-yellow-400 hover:bg-yellow-500 text-gray-900 font-extrabold text-2xl py-4 rounded transition flex items-center justify-center gap-3"
                  >
                    <Send className="w-6 h-6" />
                    INVIA
                  </button>
                </form>
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
                      href="tel:+393294011384"
                      className="flex items-center bg-green-700/60 hover:bg-green-800/80 transition rounded px-4 py-3"
                  >
                  <span className="w-10 h-10 bg-green-800/80 rounded flex items-center justify-center mr-3">
                    <Smartphone className="w-5 h-5 text-white" />
                  </span>

                    <span className="font-semibold">(+39) 329 4011384</span>
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
              {/* Copyright + pulsanti policy */}
              <div className="w-full md:w-1/2">
                <p className="text-sm text-white/90 mb-2">
                  © 2017 Il Mondo Immobiliare. All Rights Reserved. Partita IVA:
                  01585350190
                </p>

                <div className="flex flex-col items-start gap-1">
                  <button
                      type="button"
                      onClick={() => {}}
                      className="inline-flex items-center gap-1 bg-white text-gray-700 text-xs font-semibold px-2 py-1 rounded shadow hover:bg-gray-100 transition"
                  >
                  <span className="inline-flex items-center justify-center w-3 h-3 bg-green-500 text-white rounded-sm text-[9px]">
                    i
                  </span>
                    Privacy Policy
                  </button>

                  <button
                      type="button"
                      onClick={() => {}}
                      className="inline-flex items-center gap-1 bg-white text-gray-700 text-xs font-semibold px-2 py-1 rounded shadow hover:bg-gray-100 transition"
                  >
                  <span className="inline-flex items-center justify-center w-3 h-3 bg-green-500 text-white rounded-sm text-[9px]">
                    i
                  </span>
                    Cookie Policy
                  </button>
                </div>
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