import { useEffect, useState } from 'react'
import { Link, useSearchParams } from 'react-router-dom'
import {
  Home as HomeIcon,
} from 'lucide-react'
import SearchForm from '../components/SearchForm'
import axiosInstance from '../api/axiosInstance'
import PublicLayout from '../components/PublicLayout'

const BACKEND_URL =
    import.meta.env.VITE_BACKEND_URL || 'http://localhost:8080'

export default function Immobili() {
  const [urlSearchParams] = useSearchParams()

  const [immobili, setImmobili] = useState([])
  const [loading, setLoading] = useState(true)
  const [errore, setErrore] = useState('')
  const [ricercaAttiva, setRicercaAttiva] = useState(false)

  useEffect(() => {
    const filtriDaUrl = {
      localita: urlSearchParams.get('localita') || '',
      ubicazione: urlSearchParams.get('ubicazione') || '',
      destinazione: urlSearchParams.get('destinazione') || '',
      tipo: urlSearchParams.get('tipo') || '',
      camereLettoMin: urlSearchParams.get('camereLettoMin') || '',
      bagniMin: urlSearchParams.get('bagniMin') || '',
      prezzoMin: Number(urlSearchParams.get('prezzoMin') || 0),
      prezzoMax: Number(urlSearchParams.get('prezzoMax') || 2000000),
      codiceRiferimento: urlSearchParams.get('codiceRiferimento') || '',
    }

    const ciSonoFiltri =
        filtriDaUrl.localita ||
        filtriDaUrl.ubicazione ||
        filtriDaUrl.destinazione ||
        filtriDaUrl.tipo ||
        filtriDaUrl.camereLettoMin ||
        filtriDaUrl.bagniMin ||
        filtriDaUrl.codiceRiferimento ||
        filtriDaUrl.prezzoMin > 0 ||
        filtriDaUrl.prezzoMax < 2000000

    if (ciSonoFiltri) {
      cercaImmobili(filtriDaUrl)
    } else {
      caricaImmobili()
    }
  }, [urlSearchParams])

  const getFotoUrl = (immobile) => {
    const primaFoto = immobile?.fotoUrl?.[0]

    if (!primaFoto) {
      return null
    }

    if (primaFoto.startsWith('http')) {
      return primaFoto
    }

    return `${BACKEND_URL}${primaFoto}`
  }

  const normalizza = (valore) => {
    return (
        valore
            ?.toString()
            .trim()
            .toLowerCase()
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '') || ''
    )
  }

  const formatEnum = (valore) => {
    if (!valore) {
      return ''
    }

    const labels = {
      VILLA: 'Villa',
      VILLETTA: 'Villetta',
      APPARTAMENTO: 'Appartamento',
      ATTICO: 'Attico',
      ATTIVITA_COMMERCIALE: 'Attività Commerciale',
      BILOCALE: 'Bilocale',
      BOX: 'Box',
      CASA_INDIPENDENTE: 'Casa Indipendente',
      CASCINA: 'Cascina',
      FABBRICATO: 'Fabbricato',
      LABORATORIO: 'Laboratorio',
      LOFT: 'Loft',
      MAGAZZINO_CAPANNONE: 'Magazzino/Capannone',
      MANSARDA: 'Mansarda',
      MONOLOCALE: 'Monolocale',
      NEGOZIO: 'Negozio',
      RUSTICO: 'Rustico',
      STUDIO: 'Studio',
      TERRENO: 'Terreno',

      CENTRALE: 'Centrale',
      FUORI_CITTA: 'Fuori Città',
      PERIFERIA: 'Periferia',
      SEMI_CENTRALE: 'Semi-Centrale',

      AFFITTO: 'Affitto',
      AFFITTO_SEMI_ARREDATO: 'Affitto semi-arredato',
      VENDITA: 'Vendita',
    }

    return (
        labels[valore] ||
        valore
            .toString()
            .toLowerCase()
            .replaceAll('_', ' ')
            .replace(/\b\w/g, (lettera) => lettera.toUpperCase())
    )
  }

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

      if (filtri.codiceRiferimento) {
        risultati = risultati.filter((immobile) =>
            immobile.codiceRiferimento
                ?.toString()
                .toLowerCase()
                .includes(
                    filtri.codiceRiferimento.toString().trim().toLowerCase()
                )
        )
      }

      if (filtri.localita) {
        risultati = risultati.filter((immobile) =>
            normalizza(immobile.citta).includes(normalizza(filtri.localita))
        )
      }

      if (filtri.ubicazione) {
        risultati = risultati.filter(
            (immobile) =>
                normalizza(formatEnum(immobile.ubicazione)) ===
                normalizza(filtri.ubicazione)
        )
      }

      if (filtri.destinazione) {
        risultati = risultati.filter(
            (immobile) =>
                normalizza(formatEnum(immobile.destinazione)) ===
                normalizza(filtri.destinazione)
        )
      }

      if (filtri.tipo) {
        risultati = risultati.filter(
            (immobile) =>
                normalizza(formatEnum(immobile.tipo)) === normalizza(filtri.tipo)
        )
      }

      if (filtri.camereLettoMin) {
        risultati = risultati.filter(
            (immobile) =>
                Number(immobile.camereDaLetto || 0) >=
                Number(filtri.camereLettoMin)
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
      <PublicLayout activePage="immobili">
        {/* Form ricerca */}
        <SearchForm onSearch={cercaImmobili} />

        {/* Risultati immobili */}
        <main className="max-w-7xl mx-auto px-4 py-10 md:py-12">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-8">
            <h1 className="text-2xl md:text-3xl font-bold text-gray-900">
              {ricercaAttiva ? 'Risultati ricerca' : 'Immobili disponibili'}
            </h1>

            {ricercaAttiva && (
                <button
                    type="button"
                    onClick={caricaImmobili}
                    className="bg-gray-800 hover:bg-gray-900 text-white px-5 py-3 md:py-2 rounded-lg font-semibold transition"
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
                {immobili.map((immobile) => {
                  const fotoCopertina = getFotoUrl(immobile)

                  return (
                      <article
                          key={immobile.id}
                          className="bg-white rounded-xl shadow-md overflow-hidden hover:shadow-lg transition"
                      >
                        <div className="h-48 bg-gray-200 flex items-center justify-center overflow-hidden">
                          {fotoCopertina ? (
                              <img
                                  src={fotoCopertina}
                                  alt={immobile.titolo}
                                  className="w-full h-full object-cover"
                              />
                          ) : (
                              <HomeIcon className="w-16 h-16 text-gray-400" />
                          )}
                        </div>

                        <div className="p-5 md:p-6">
                          <h2 className="text-xl font-bold text-gray-900 mb-2">
                            {immobile.titolo}
                          </h2>

                          {immobile.codiceRiferimento && (
                              <p className="text-sm font-semibold text-green-700 mb-2">
                                Rif. {immobile.codiceRiferimento}
                              </p>
                          )}

                          <p className="text-gray-600 mb-4 line-clamp-2">
                            {immobile.descrizione}
                          </p>

                          <div className="space-y-1 text-sm text-gray-600 mb-4">
                            <p>
                              <strong>Città:</strong> {immobile.citta}
                            </p>

                            <p>
                              <strong>Tipo:</strong>{' '}
                              {immobile.tipo
                                  ? immobile.tipo
                                      .split(',')
                                      .map((tipo) => formatEnum(tipo.trim()))
                                      .join(', ')
                                  : 'Non specificato'}
                            </p>

                            <p>
                              <strong>Camere:</strong>{' '}
                              {immobile.camereDaLetto || '-'}
                            </p>

                            <p>
                              <strong>Bagni:</strong> {immobile.numeroBagni || '-'}
                            </p>

                            <p>
                              <strong>Superficie:</strong>{' '}
                              {immobile.superficieMq || '-'} m²
                            </p>
                          </div>

                          <div className="flex flex-col sm:flex-row sm:justify-between sm:items-center gap-4">
                            <p className="text-2xl font-bold text-green-600">
                              € {Number(immobile.prezzo).toLocaleString('it-IT')}
                            </p>

                            <Link
                                to={`/immobili/${immobile.id}`}
                                className="bg-yellow-400 hover:bg-yellow-500 text-gray-900 font-semibold px-4 py-3 sm:py-2 rounded-lg transition text-center whitespace-nowrap"
                            >
                              Dettagli
                            </Link>
                          </div>
                        </div>
                      </article>
                  )
                })}
              </div>
          )}
        </main>
      </PublicLayout>
  )
}