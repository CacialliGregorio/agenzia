import { useState, useEffect } from 'react'
import { useNavigate, Link } from 'react-router-dom'
import axiosInstance from '../api/axiosInstance'
import {
  MapPin,
  Home as HomeIcon,
  LogIn,
  Plus,
  Facebook,
  Instagram,
  ChevronLeft,
  ChevronRight,
  Ruler,
  BedDouble,
  Bath,
  Phone,
  Smartphone,
  Mail,
  MapPinned,
} from 'lucide-react'
import SearchForm from '../components/SearchForm'
import WhatsAppTopLink from '../components/WhatsAppTopLink'
const BACKEND_URL =
    import.meta.env.VITE_BACKEND_URL || 'http://localhost:8080'

export default function Home() {
  const [immobili, setImmobili] = useState([])
  const [heroImmobili, setHeroImmobili] = useState([])
  const [heroIndex, setHeroIndex] = useState(0)
  const [loading, setLoading] = useState(true)

  const navigate = useNavigate()
  const token = localStorage.getItem('token')

  useEffect(() => {
    fetchImmobili()
  }, [])

  useEffect(() => {
    if (heroImmobili.length <= 1) {
      return
    }

    const intervallo = setInterval(() => {
      setHeroIndex((indexCorrente) =>
          indexCorrente === heroImmobili.length - 1 ? 0 : indexCorrente + 1
      )
    }, 5000)

    return () => clearInterval(intervallo)
  }, [heroImmobili])

  const fetchImmobili = async () => {
    setLoading(true)

    try {
      const response = await axiosInstance.get('/immobili', {
        params: {
          page: 0,
          size: 1000,
        },
      })

      const immobiliDisponibili = response.data.content || []

      setImmobili(immobiliDisponibili.slice(0, 6))

      const immobiliConFoto = immobiliDisponibili.filter(
          (immobile) => immobile.fotoUrl && immobile.fotoUrl.length > 0
      )

      const baseHero =
          immobiliConFoto.length >= 3 ? immobiliConFoto : immobiliDisponibili

      const casuali = [...baseHero]
          .sort(() => Math.random() - 0.5)
          .slice(0, 3)

      setHeroImmobili(casuali)
      setHeroIndex(0)
    } catch (error) {
      console.error('Errore nel caricamento annunci:', error)
    } finally {
      setLoading(false)
    }
  }

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

  const handleSearchHome = (filtri) => {
    const params = new URLSearchParams()
    if (filtri.codiceRiferimento) {
      params.set('codiceRiferimento', filtri.codiceRiferimento)
    }

    if (filtri.localita) {
      params.set('localita', filtri.localita)
    }

    if (filtri.ubicazione) {
      params.set('ubicazione', filtri.ubicazione)
    }

    if (filtri.destinazione) {
      params.set('destinazione', filtri.destinazione)
    }

    if (filtri.tipo) {
      params.set('tipo', filtri.tipo)
    }

    if (filtri.camereLettoMin) {
      params.set('camereLettoMin', filtri.camereLettoMin)
    }

    if (filtri.bagniMin) {
      params.set('bagniMin', filtri.bagniMin)
    }

    if (filtri.prezzoMin !== undefined && filtri.prezzoMin !== null) {
      params.set('prezzoMin', filtri.prezzoMin)
    }

    if (filtri.prezzoMax !== undefined && filtri.prezzoMax !== null) {
      params.set('prezzoMax', filtri.prezzoMax)
    }

    navigate(`/immobili?${params.toString()}`)
  }

  const vaiSlidePrecedente = () => {
    if (heroImmobili.length === 0) {
      return
    }

    setHeroIndex((indexCorrente) =>
        indexCorrente === 0 ? heroImmobili.length - 1 : indexCorrente - 1
    )
  }

  const vaiSlideSuccessiva = () => {
    if (heroImmobili.length === 0) {
      return
    }

    setHeroIndex((indexCorrente) =>
        indexCorrente === heroImmobili.length - 1 ? 0 : indexCorrente + 1
    )
  }

  const immobileHero = heroImmobili[heroIndex]
  const fotoHero = immobileHero ? getFotoUrl(immobileHero) : null

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
                  <Link
                      to="/dashboard"
                      className="hover:text-gray-300 flex items-center gap-1"
                  >
                    <Plus className="w-4 h-4" />
                    Dashboard
                  </Link>
              ) : (
                  <button
                      onClick={() => navigate('/login')}
                      className="hover:text-gray-300 flex items-center gap-1"
                  >
                    <LogIn className="w-4 h-4" />
                    Area Dipendenti
                  </button>
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
              <Link to="/" className="text-blue-600 font-medium">
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

        {/* Hero Slider annunci */}
        <section className="relative h-[560px] bg-gray-900 overflow-hidden">
          {immobileHero ? (
              <>
                {fotoHero ? (
                    <img
                        src={fotoHero}
                        alt={immobileHero.titolo}
                        className="absolute inset-0 w-full h-full object-cover"
                    />
                ) : (
                    <div className="absolute inset-0 bg-gradient-to-r from-blue-500 to-indigo-600 flex items-center justify-center">
                      <HomeIcon className="w-28 h-28 text-white opacity-80" />
                    </div>
                )}

                <div className="absolute inset-0 bg-black/25"></div>

                <button
                    type="button"
                    onClick={vaiSlidePrecedente}
                    className="absolute left-8 top-1/2 -translate-y-1/2 z-10 w-16 h-32 border border-white/20 text-white/70 hover:text-white hover:bg-white/10 transition flex items-center justify-center"
                >
                  <ChevronLeft className="w-10 h-10" />
                </button>

                <button
                    type="button"
                    onClick={vaiSlideSuccessiva}
                    className="absolute right-8 top-1/2 -translate-y-1/2 z-10 w-16 h-32 border border-white/20 text-white/70 hover:text-white hover:bg-white/10 transition flex items-center justify-center"
                >
                  <ChevronRight className="w-10 h-10" />
                </button>

                <div className="absolute left-0 right-0 top-[38%] -translate-y-1/2 bg-black/45 py-12">
                  <div className="max-w-7xl mx-auto px-4 text-center">
                    <h1 className="text-4xl md:text-5xl font-extrabold text-white uppercase tracking-wide">
                      {immobileHero.titolo}
                    </h1>
                  </div>
                </div>

                <div className="absolute left-0 right-0 top-[55%] -translate-y-1/2 bg-black/70 py-6">
                  <div className="max-w-7xl mx-auto px-4 flex justify-center items-center gap-12 text-white">
                    <div className="flex items-center gap-2">
                      <Ruler className="w-6 h-6 text-green-400" />
                      <span className="text-lg">
                    {immobileHero.superficieMq || '-'} m²
                  </span>
                    </div>

                    <div className="flex items-center gap-2">
                      <BedDouble className="w-6 h-6 text-green-400" />
                      <span className="text-lg">
                    {immobileHero.numeroLocali || '-'}
                  </span>
                    </div>

                    <div className="flex items-center gap-2">
                      <Bath className="w-6 h-6 text-green-400" />
                      <span className="text-lg">
                    {immobileHero.numeroBagni || '-'}
                  </span>
                    </div>
                  </div>
                </div>

                <div className="absolute left-0 right-0 top-[70%] -translate-y-1/2 text-center">
                  <Link
                      to={`/immobili/${immobileHero.id}`}
                      className="inline-block bg-yellow-400 hover:bg-yellow-500 text-gray-900 font-extrabold text-2xl px-16 py-4 rounded transition"
                  >
                    DETTAGLI
                  </Link>
                </div>

                <div className="absolute bottom-6 left-0 right-0 flex justify-center gap-2">
                  {heroImmobili.map((_, index) => (
                      <button
                          key={index}
                          type="button"
                          onClick={() => setHeroIndex(index)}
                          className={`w-3 h-3 rounded-full transition ${
                              index === heroIndex ? 'bg-white' : 'bg-white/50'
                          }`}
                      />
                  ))}
                </div>
              </>
          ) : (
              <div className="h-full flex items-center justify-center text-white">
                Caricamento annunci...
              </div>
          )}
        </section>

        {/* Search */}
        <SearchForm onSearch={handleSearchHome} />

        {/* Annunci Grid */}
        <section className="max-w-7xl mx-auto px-4 py-12">
          <div className="mb-8">
            <h2 className="text-3xl font-bold text-gray-900">
              Ultimi immobili disponibili
            </h2>
            <p className="text-gray-600 mt-2">
              Una selezione degli immobili attualmente disponibili.
            </p>
          </div>

          {loading ? (
              <div className="text-center py-12">
                <p className="text-gray-600">Caricamento annunci...</p>
              </div>
          ) : immobili.length === 0 ? (
              <div className="text-center py-12">
                <p className="text-gray-600">Nessun immobile trovato</p>
              </div>
          ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {immobili.map((immobile) => {
                  const fotoCopertina = getFotoUrl(immobile)

                  return (
                      <Link
                          key={immobile.id}
                          to={`/immobili/${immobile.id}`}
                          className="bg-white rounded-lg shadow-md hover:shadow-xl transition-shadow overflow-hidden"
                      >
                        <div className="h-48 bg-gray-200 flex items-center justify-center overflow-hidden">
                          {fotoCopertina ? (
                              <img
                                  src={fotoCopertina}
                                  alt={immobile.titolo}
                                  className="w-full h-full object-cover"
                              />
                          ) : (
                              <div className="bg-gradient-to-r from-blue-400 to-indigo-400 w-full h-full flex items-center justify-center">
                                <HomeIcon className="w-12 h-12 text-white" />
                              </div>
                          )}
                        </div>

                        <div className="p-4">
                          <h3 className="font-bold text-lg text-gray-800 mb-2 line-clamp-2">
                            {immobile.titolo}
                          </h3>

                          <div className="flex items-center gap-2 text-gray-600 mb-2">
                            <MapPin className="w-4 h-4" />
                            <span>
                        {immobile.citta}
                              {immobile.provincia ? `, ${immobile.provincia}` : ''}
                      </span>
                          </div>

                          <div className="flex items-center gap-2 text-blue-600 font-bold">
                            <span>
                        {Number(immobile.prezzo).toLocaleString('it-IT')} €
                      </span>
                          </div>

                          <div className="text-sm text-gray-500 mt-3 pt-3 border-t">
                            {immobile.numeroLocali || '-'} locali ·{' '}
                            {immobile.superficieMq || '-'} m²
                          </div>
                        </div>
                      </Link>
                  )
                })}
              </div>
          )}
        </section>

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