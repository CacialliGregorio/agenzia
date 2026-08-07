import {
  Briefcase,
} from 'lucide-react'
import PublicLayout from '../components/PublicLayout'

export default function Servizi() {
  return (
      <PublicLayout activePage="servizi">
        <main className="max-w-7xl mx-auto px-4 py-10 md:py-12">
          <h1 className="text-3xl md:text-4xl font-bold text-gray-800 mb-8">
            I Nostri Servizi
          </h1>

          {/* Tre box servizi */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 md:gap-8 mb-12 md:mb-16">
            <div className="bg-white p-6 rounded-lg shadow hover:shadow-lg transition">
              <Briefcase className="w-8 h-8 text-blue-600 mb-3" />

              <h2 className="text-lg font-bold mb-2">Vendita Immobili</h2>

              <p className="text-gray-600 leading-7">
                Assistenza completa nella compravendita di proprietà.
              </p>
            </div>

            <div className="bg-white p-6 rounded-lg shadow hover:shadow-lg transition">
              <Briefcase className="w-8 h-8 text-blue-600 mb-3" />

              <h2 className="text-lg font-bold mb-2">Affitti</h2>

              <p className="text-gray-600 leading-7">
                Gestione e ricerca di soluzioni abitative in affitto.
              </p>
            </div>

            <div className="bg-white p-6 rounded-lg shadow hover:shadow-lg transition">
              <Briefcase className="w-8 h-8 text-blue-600 mb-3" />

              <h2 className="text-lg font-bold mb-2">Consulenza</h2>

              <p className="text-gray-600 leading-7">
                Consulenza specializzata nel settore immobiliare.
              </p>
            </div>
          </div>

          {/* Testo descrittivo */}
          <section className="bg-gray-50 px-2 md:px-4 py-8 md:py-12 mb-12">
            <div className="max-w-6xl mx-auto text-center">
              <p className="text-xl md:text-3xl text-gray-600 leading-8 md:leading-relaxed mb-8">
                L’agenzia{' '}
                <strong className="font-bold text-gray-700">
                  “Il Mondo Immobiliare”
                </strong>{' '}
                offre alla propria clientela un insieme di servizi integrati in
                grado di soddisfare tutte le esigenze di chi compra, vende, affitta
                o ricerca un immobile.
              </p>

              <p className="text-xl md:text-3xl text-gray-600 leading-8 md:leading-relaxed mb-10 md:mb-12">
                La professionalità del proprio staff consente di risolvere con
                efficienza e tempestività tutte le pratiche burocratiche e gli
                adempimenti fiscali connessi come:
              </p>

              <div className="max-w-2xl mx-auto text-left border-l-4 border-gray-200 pl-5 md:pl-8">
                <ul className="text-lg md:text-xl text-gray-600 leading-9 md:leading-10">
                  <li>- stipula e la registrazione di contratti;</li>
                  <li>- risoluzioni contratti;</li>
                  <li>- valutazioni e perizie;</li>
                  <li>- assistenza fiscale e finanziaria;</li>
                  <li>- ricerca clienti;</li>
                  <li>- certificazioni energetiche.</li>
                </ul>
              </div>
            </div>
          </section>
        </main>
      </PublicLayout>
  )
}