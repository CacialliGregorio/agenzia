import { useState } from 'react'
import {
  Phone,
  Mail,
  MapPin,
  Send,
} from 'lucide-react'
import PublicLayout from '../components/PublicLayout'
import { siteConfig } from '../config/siteConfig.js'

export default function Contatti() {
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

    const linkWhatsapp = `${siteConfig.whatsappUrl}?text=${encodeURIComponent(
        testo
    )}`

    window.open(linkWhatsapp, '_blank')
  }

  return (
      <PublicLayout activePage="contatti">
        <main className="max-w-7xl mx-auto px-4 py-10 md:py-12">
          <h1 className="text-3xl md:text-4xl font-bold text-gray-800 mb-8">
            Contatti
          </h1>

          {/* Riquadri contatti */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 md:gap-8 mb-12">
            <div className="bg-white p-6 rounded-lg shadow">
              <Phone className="w-8 h-8 text-blue-600 mb-3" />

              <h2 className="text-lg font-bold mb-2">Telefono</h2>

              <a
                  href={siteConfig.telefonoHref}
                  className="text-blue-600 hover:underline"
              >
                {siteConfig.telefono}
              </a>
            </div>

            <div className="bg-white p-6 rounded-lg shadow">
              <Mail className="w-8 h-8 text-blue-600 mb-3" />

              <h2 className="text-lg font-bold mb-2">Email</h2>

              <a
                  href={siteConfig.emailHref}
                  className="text-blue-600 hover:underline break-all"
              >
                {siteConfig.email}
              </a>
            </div>

            <div className="bg-white p-6 rounded-lg shadow">
              <MapPin className="w-8 h-8 text-blue-600 mb-3" />

              <h2 className="text-lg font-bold mb-2">Ubicazione</h2>

              <a
                  href={siteConfig.mapsUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-blue-600 hover:underline"
              >
                {siteConfig.indirizzo}
                <br />
                26100 Cremona
              </a>
            </div>
          </div>

          {/* Mappa + form WhatsApp */}
          <section className="bg-white rounded-xl shadow-lg overflow-hidden mb-12">
            <div className="grid grid-cols-1 lg:grid-cols-2">
              {/* Mappa */}
              <div className="min-h-[340px] md:min-h-[520px]">
                <iframe
                    title="Mappa Il Mondo Immobiliare"
                    src="https://www.google.com/maps?q=Viale%20Trento%20e%20Trieste%20120%20Cremona&output=embed"
                    className="w-full h-full min-h-[340px] md:min-h-[520px] border-0"
                    loading="lazy"
                    referrerPolicy="no-referrer-when-downgrade"
                ></iframe>
              </div>

              {/* Form */}
              <div className="p-6 md:p-8 lg:p-10">
                <h2 className="text-3xl md:text-4xl font-light text-gray-900 mb-5">
                  Mandaci un messaggio
                </h2>

                <p className="text-base md:text-xl text-gray-600 leading-7 md:leading-8 mb-8">
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
                        className="w-full px-5 py-4 border border-gray-300 rounded text-base md:text-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                    />

                    <input
                        type="email"
                        name="email"
                        value={formData.email}
                        onChange={handleChange}
                        placeholder="Email*"
                        className="w-full px-5 py-4 border border-gray-300 rounded text-base md:text-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                    />
                  </div>

                  <input
                      type="text"
                      name="oggetto"
                      value={formData.oggetto}
                      onChange={handleChange}
                      placeholder="Oggetto"
                      className="w-full px-5 py-4 border border-gray-300 rounded text-base md:text-lg focus:outline-none focus:ring-2 focus:ring-green-500"
                  />

                  <textarea
                      name="messaggio"
                      value={formData.messaggio}
                      onChange={handleChange}
                      placeholder="Messaggio"
                      rows="7"
                      className="w-full px-5 py-4 border border-gray-300 rounded text-base md:text-lg resize-none focus:outline-none focus:ring-2 focus:ring-green-500"
                  />

                  <label className="flex items-start gap-3 text-gray-600 text-base md:text-lg leading-7 border border-gray-300 rounded px-4 py-4">
                    <input
                        type="checkbox"
                        name="privacy"
                        checked={formData.privacy}
                        onChange={handleChange}
                        className="mt-1 w-5 h-5 shrink-0"
                    />

                    <span>
                      Sì, inviando questo messaggio accetto la privacy policy del
                      sito web sul trattamento dei miei dati personali.
                    </span>
                  </label>

                  <button
                      type="submit"
                      className="w-full bg-yellow-400 hover:bg-yellow-500 text-gray-900 font-extrabold text-xl md:text-2xl py-4 rounded transition flex items-center justify-center gap-3"
                  >
                    <Send className="w-6 h-6" />
                    INVIA
                  </button>
                </form>
              </div>
            </div>
          </section>
        </main>
      </PublicLayout>
  )
}