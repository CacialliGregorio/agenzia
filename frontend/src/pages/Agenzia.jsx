import {
  Users,
  Award,
  ShieldCheck,
} from 'lucide-react'
import PublicLayout from '../components/PublicLayout'
import immagineAgenzia from './00.jpg'

export default function Agenzia() {
  return (
      <PublicLayout activePage="agenzia">
        <main className="max-w-7xl mx-auto px-4 py-10 md:py-12">
          {/* Titolo e testo come sito originale */}
          <section className="text-center mb-10 md:mb-12">
            <h1 className="text-4xl md:text-5xl font-light text-gray-800 mb-8 md:mb-10">
              L’Agenzia
            </h1>

            <div className="border-t border-gray-300 mb-8 md:mb-12"></div>

            <p className="text-lg md:text-xl text-gray-600 leading-8 md:leading-9 max-w-6xl mx-auto">
              L’agenzia{' '}
              <strong className="font-bold text-gray-700">
                “Il Mondo Immobiliare”
              </strong>{' '}
              opera sin dal 1996 prevalentemente nella città di Cremona e sul suo
              territorio dove nel corso degli anni si è affermata grazie alla
              correttezza nei rapporti con il cliente, la serietà e capacità
              professionale specialmente nel settore delle compravendite
              immobiliari e locazioni.
            </p>
          </section>

          {/* Immagine agenzia */}
          <section className="mb-12 md:mb-14">
            <img
                src={immagineAgenzia}
                alt="Il Mondo Immobiliare Agenzia"
                className="w-full max-h-[420px] md:max-h-[620px] object-cover rounded-lg shadow-lg"
            />
          </section>

          {/* Tre box sotto */}
          <section className="grid grid-cols-1 md:grid-cols-3 gap-6 md:gap-8 mb-12">
            <div className="bg-white p-6 md:p-7 rounded-lg shadow hover:shadow-lg transition">
              <Users className="w-10 h-10 text-blue-600 mb-4" />

              <h2 className="text-xl font-bold mb-3">Team Professionale</h2>

              <p className="text-gray-600 leading-7">
                Un team dedicato e competente al vostro servizio.
              </p>
            </div>

            <div className="bg-white p-6 md:p-7 rounded-lg shadow hover:shadow-lg transition">
              <Award className="w-10 h-10 text-blue-600 mb-4" />

              <h2 className="text-xl font-bold mb-3">Esperienza</h2>

              <p className="text-gray-600 leading-7">
                Anni di esperienza nel settore immobiliare.
              </p>
            </div>

            <div className="bg-white p-6 md:p-7 rounded-lg shadow hover:shadow-lg transition">
              <ShieldCheck className="w-10 h-10 text-blue-600 mb-4" />

              <h2 className="text-xl font-bold mb-3">Affidabilità</h2>

              <p className="text-gray-600 leading-7">
                Trasparenza e professionalità in ogni trattativa.
              </p>
            </div>
          </section>
        </main>
      </PublicLayout>
  )
}