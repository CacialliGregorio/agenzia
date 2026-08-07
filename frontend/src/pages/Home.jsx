import { useState, useEffect } from 'react'
import { useNavigate, Link } from 'react-router-dom'
import axiosInstance from '../api/axiosInstance'
import {
  MapPin,
  Home as HomeIcon,
  ChevronLeft,
  ChevronRight,
  Ruler,
  BedDouble,
  Bath,
  Star,
} from 'lucide-react'
import SearchForm from '../components/SearchForm'
import PublicLayout from '../components/PublicLayout'

const BACKEND_URL =
    import.meta.env.VITE_BACKEND_URL || 'http://localhost:8080'

export default function Home() {
  const [immobili, setImmobili] = useState([])
  const [heroImmobili, setHeroImmobili] = useState([])
  const [heroIndex, setHeroIndex] = useState(0)
  const [loading, setLoading] = useState(true)

  const navigate = useNavigate()

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

      try {
        const responseSlide = await axiosInstance.get('/immobili/slide')

        const immobiliSlide = responseSlide.data || []

        if (immobiliSlide.length > 0) {
          setHeroImmobili(immobiliSlide)
          setHeroIndex(0)
          return
        }
      } catch (error) {
        console.error('Errore nel caricamento immobili slide:', error)
      }

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
      <PublicLayout activePage="home">
        {/* Hero Slider annunci */}
        <section className="relative h-[430px] md:h-[560px] bg-gray-900 overflow-hidden">
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
                      <HomeIcon className="w-20 h-20 md:w-28 md:h-28 text-white opacity-80" />
                    </div>
                )}

                <div className="absolute inset-0 bg-black/25"></div>

                <button
                    type="button"
                    onClick={vaiSlidePrecedente}
                    className="absolute left-2 md:left-8 top-1/2 -translate-y-1/2 z-10 w-10 md:w-16 h-20 md:h-32 border border-white/20 text-white/70 hover:text-white hover:bg-white/10 transition flex items-center justify-center"
                >
                  <ChevronLeft className="w-7 h-7 md:w-10 md:h-10" />
                </button>

                <button
                    type="button"
                    onClick={vaiSlideSuccessiva}
                    className="absolute right-2 md:right-8 top-1/2 -translate-y-1/2 z-10 w-10 md:w-16 h-20 md:h-32 border border-white/20 text-white/70 hover:text-white hover:bg-white/10 transition flex items-center justify-center"
                >
                  <ChevronRight className="w-7 h-7 md:w-10 md:h-10" />
                </button>

                <div className="absolute left-0 right-0 top-[35%] md:top-[38%] -translate-y-1/2 bg-black/45 py-7 md:py-12">
                  <div className="max-w-7xl mx-auto px-4 text-center">
                    <h1 className="text-2xl md:text-5xl font-extrabold text-white uppercase tracking-wide px-4 leading-tight">
                      {immobileHero.titolo}
                    </h1>
                  </div>
                </div>

                <div className="absolute left-0 right-0 top-[54%] md:top-[55%] -translate-y-1/2 bg-black/70 py-5 md:py-6">
                  <div className="max-w-7xl mx-auto px-4 flex justify-center items-center gap-5 md:gap-12 text-white">
                    <div className="flex items-center gap-1 md:gap-2">
                      <Ruler className="w-5 h-5 md:w-6 md:h-6 text-green-400" />
                      <span className="text-sm md:text-lg">
                        {immobileHero.superficieMq || '-'} m²
                      </span>
                    </div>

                    <div className="flex items-center gap-1 md:gap-2">
                      <BedDouble className="w-5 h-5 md:w-6 md:h-6 text-green-400" />
                      <span className="text-sm md:text-lg">
                        {immobileHero.numeroLocali || '-'}
                      </span>
                    </div>

                    <div className="flex items-center gap-1 md:gap-2">
                      <Bath className="w-5 h-5 md:w-6 md:h-6 text-green-400" />
                      <span className="text-sm md:text-lg">
                        {immobileHero.numeroBagni || '-'}
                      </span>
                    </div>
                  </div>
                </div>

                <div className="absolute left-0 right-0 top-[70%] -translate-y-1/2 text-center">
                  <Link
                      to={`/immobili/${immobileHero.id}`}
                      className="inline-block bg-yellow-400 hover:bg-yellow-500 text-gray-900 font-extrabold text-lg md:text-2xl px-8 md:px-16 py-3 md:py-4 rounded transition"
                  >
                    DETTAGLI
                  </Link>
                </div>

                <div className="absolute bottom-5 md:bottom-6 left-0 right-0 flex justify-center gap-2">
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
        <section className="max-w-7xl mx-auto px-4 py-10 md:py-12">
          <div className="mb-8">
            <h2 className="text-2xl md:text-3xl font-bold text-gray-900">
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

        {/* Sezione Recensioni */}
        <section className="bg-gray-100 py-12 md:py-16">
          <div className="max-w-7xl mx-auto px-4">
            <div className="bg-white rounded-2xl shadow-lg p-6 md:p-10">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-8 items-center">
                <div>
                  <div className="flex items-center gap-2 mb-4">
                    {[1, 2, 3, 4, 5].map((stella) => (
                        <Star
                            key={stella}
                            className="w-6 h-6 md:w-7 md:h-7 fill-yellow-400 text-yellow-400"
                        />
                    ))}
                  </div>

                  <h2 className="text-2xl md:text-3xl font-bold text-gray-900 mb-4">
                    Hai già avuto a che fare con noi?
                  </h2>

                  <p className="text-gray-600 text-base md:text-lg leading-7 md:leading-8">
                    Lascia una recensione anonima sulla tua esperienza con Il
                    Mondo Immobiliare oppure leggi le recensioni lasciate dagli
                    altri clienti.
                  </p>
                </div>

                <div className="flex flex-col sm:flex-row md:justify-end gap-4">
                  <Link
                      to="/recensioni"
                      className="bg-yellow-400 text-gray-900 px-6 md:px-8 py-4 rounded-lg font-bold hover:bg-yellow-500 transition text-center"
                  >
                    Lascia una recensione
                  </Link>

                  <Link
                      to="/recensioni"
                      className="bg-gray-900 text-white px-6 md:px-8 py-4 rounded-lg font-bold hover:bg-gray-800 transition text-center"
                  >
                    Vedi recensioni
                  </Link>
                </div>
              </div>
            </div>
          </div>
        </section>
      </PublicLayout>
  )
}