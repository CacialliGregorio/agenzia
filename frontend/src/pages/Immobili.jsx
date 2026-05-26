import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { LogIn, Facebook, Instagram, Home as HomeIcon } from 'lucide-react'
import SearchForm from '../components/SearchForm'
import axiosInstance from '../api/axiosInstance'

export default function Immobili() {
  const token = localStorage.getItem('token')

  const [immobili, setImmobili] = useState([])
  const [loading, setLoading] = useState(true)
  const [errore, setErrore] = useState('')
  const [ricercaAttiva, setRicercaAttiva] = useState(false)

  useEffect(() => {
    caricaImmobili()
  }, [])

  const caricaImmobili = async () => {
    try {
      setLoading(true)
      setErrore('')
      setRicercaAttiva(false)

      const response = await axiosInstance.get('/immobili', {
        params: {
          page: 0,
          size: 1000,
        },
      })

      setImmobili(response.data.content || [])
    } catch (error) {
      console.error('Errore caricamento immobili:', error)
      setErrore('Errore durante il caricamento degli immobili.')
    } finally {
      setLoading(false)
    }
  }

  const cercaImmobili = async (filtri) => {
    try {
      setLoading(true)
      setErrore('')
      setRicercaAttiva(true)

      const response = await axiosInstance.get('/immobili', {
        params: {
          page: 0,
          size: 1000,
        },
      })

      let risultati = response.data.content || []

      if (filtri.localita) {
        risultati = risultati.filter((immobile) =>
            immobile.citta
                ?.toLowerCase()
                .includes(filtri.localita.toLowerCase())
        )
      }

      if (filtri.tipo) {
        risultati = risultati.filter((immobile) => {
          const tipoImmobile = immobile.tipo?.toLowerCase() || ''
          const tipoCercato = filtri.tipo.toLowerCase()

          if (tipoCercato === 'bilocale') {
            return immobile.numeroLocali === 2
          }

          if (tipoCercato === 'attico') {
            return immobile.piano >= 4
          }

          if (tipoCercato === 'casa indipendente') {
            return tipoImmobile === 'casa'
          }

          return tipoImmobile.includes(tipoCercato)
        })
      }

      if (filtri.camereLettoMin) {
        risultati = risultati.filter(
            (immobile) =>
                Number(immobile.numeroLocali || 0) >= Number(filtri.camereLettoMin)
        )
      }

      if (filtri.bagniMin) {
        risultati = risultati.filter(
            (immobile) =>
                Number(immobile.numeroBagni || 0) >= Number(filtri.bagniMin)
        )
      }

      risultati = risultati.filter((immobile) => {
        const prezzo = Number(immobile.prezzo || 0)

        return (
            prezzo >= Number(filtri.prezzoMin || 0) &&
            prezzo <= Number(filtri.prezzoMax || 2000000)
        )
      })

      setImmobili(risultati)
    } catch (error) {
      console.error('Errore ricerca immobili:', error)
      setErrore('Errore durante la ricerca degli immobili.')
    } finally {
      setLoading(false)
    }
  }

  return (
      <div className="min-h-screen bg-gray-50">
        {/* Top Bar */}
        <div className="bg-gray-900 text-white text-sm py-2">
          <div className="max-w-7xl mx-auto px-4 flex justify-between items-center">
            <div className="flex gap-4 items-center">
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
        <header className="bg-white shadow-sm sticky top-0 z-10">
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

              <Link to="/immobili" className="text-blue-600 font-medium">
                Immobili
              </Link>

              <Link
                  to="/contatti"
                  className="text-gray-700 hover:text-blue-600 font-medium"
              >
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

        {/* Form ricerca */}
        <SearchForm onSearch={cercaImmobili} />

        {/* Risultati immobili */}
        <div className="max-w-7xl mx-auto px-4 py-12">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-8">
            <h2 className="text-3xl font-bold text-gray-900">
              {ricercaAttiva ? 'Risultati ricerca' : 'Immobili disponibili'}
            </h2>

            {ricercaAttiva && (
                <button
                    type="button"
                    onClick={caricaImmobili}
                    className="bg-gray-800 hover:bg-gray-900 text-white px-5 py-2 rounded-lg font-semibold transition"
                >
                  Mostra tutti
                </button>
            )}
          </div>

          {loading && (
              <p className="text-gray-600 text-lg">Caricamento immobili...</p>
          )}

          {errore && <p className="text-red-600 text-lg">{errore}</p>}

          {!loading && !errore && immobili.length === 0 && (
              <p className="text-gray-600 text-lg">
                Nessun immobile trovato con questi filtri.
              </p>
          )}

          {!loading && !errore && immobili.length > 0 && (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                {immobili.map((immobile) => (
                    <div
                        key={immobile.id}
                        className="bg-white rounded-xl shadow-md overflow-hidden hover:shadow-lg transition"
                    >
                      <div className="h-48 bg-gray-200 flex items-center justify-center">
                        <HomeIcon className="w-16 h-16 text-gray-400" />
                      </div>

                      <div className="p-6">
                        <h3 className="text-xl font-bold text-gray-900 mb-2">
                          {immobile.titolo}
                        </h3>

                        <p className="text-gray-600 mb-4 line-clamp-2">
                          {immobile.descrizione}
                        </p>

                        <div className="space-y-1 text-sm text-gray-600 mb-4">
                          <p>
                            <strong>Città:</strong> {immobile.citta}
                          </p>

                          <p>
                            <strong>Tipo:</strong> {immobile.tipo}
                          </p>

                          <p>
                            <strong>Locali:</strong> {immobile.numeroLocali}
                          </p>

                          <p>
                            <strong>Bagni:</strong> {immobile.numeroBagni}
                          </p>

                          <p>
                            <strong>Superficie:</strong> {immobile.superficieMq} m²
                          </p>
                        </div>

                        <div className="flex justify-between items-center gap-4">
                          <p className="text-2xl font-bold text-green-600">
                            € {Number(immobile.prezzo).toLocaleString('it-IT')}
                          </p>

                          <Link
                              to={`/immobili/${immobile.id}`}
                              className="bg-yellow-400 hover:bg-yellow-500 text-gray-900 font-semibold px-4 py-2 rounded-lg transition whitespace-nowrap"
                          >
                            Dettagli
                          </Link>
                        </div>
                      </div>
                    </div>
                ))}
              </div>
          )}
        </div>
      </div>
  )
}