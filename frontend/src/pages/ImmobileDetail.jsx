import { useState, useEffect } from 'react'
import { useParams, useNavigate, Link } from 'react-router-dom'
import axiosInstance from '../api/axiosInstance'
import {
  ArrowLeft,
  MapPin,
  Ruler,
  Home as HomeIcon,
  Droplet,
  Zap,
  ChevronLeft,
  ChevronRight,
} from 'lucide-react'
import PublicLayout from '../components/PublicLayout'

const BACKEND_URL =
    import.meta.env.VITE_BACKEND_URL || 'http://localhost:8080'

export default function ImmobileDetail() {
  const { id } = useParams()
  const navigate = useNavigate()

  const [immobile, setImmobile] = useState(null)
  const [loading, setLoading] = useState(true)
  const [fotoSelezionata, setFotoSelezionata] = useState(0)

  useEffect(() => {
    fetchImmobile()
  }, [id])

  const fetchImmobile = async () => {
    try {
      const response = await axiosInstance.get(`/immobili/${id}`)
      setImmobile(response.data)
    } catch (error) {
      console.error('Errore nel caricamento immobile:', error)
      navigate('/immobili')
    } finally {
      setLoading(false)
    }
  }

  const getFotoUrl = (foto) => {
    if (!foto) {
      return null
    }

    if (foto.startsWith('http')) {
      return foto
    }

    return `${BACKEND_URL}${foto}`
  }

  const fotoDisponibili = immobile?.fotoUrl || []

  const fotoPrincipale =
      fotoDisponibili.length > 0
          ? getFotoUrl(fotoDisponibili[fotoSelezionata])
          : null

  const vaiFotoPrecedente = () => {
    setFotoSelezionata((prev) =>
        prev === 0 ? fotoDisponibili.length - 1 : prev - 1
    )
  }

  const vaiFotoSuccessiva = () => {
    setFotoSelezionata((prev) =>
        prev === fotoDisponibili.length - 1 ? 0 : prev + 1
    )
  }

  const caratteristiche = [
    { key: 'ascensore', label: 'Ascensore' },
    { key: 'garage', label: 'Garage' },
    { key: 'pannelliSolari', label: 'Pannelli Solari' },
    { key: 'terrazza', label: 'Terrazza' },
    { key: 'riscaldamentoPavimento', label: 'Riscaldamento a Pavimento' },
    { key: 'giardino', label: 'Giardino' },
    { key: 'piscina', label: 'Piscina' },
    { key: 'impiantoAllarme', label: 'Impianto Allarme' },
    { key: 'ariaCondizionata', label: 'Aria Condizionata' },
    { key: 'vistaPanoramica', label: 'Vista Panoramica' },
    { key: 'ripostiglio', label: 'Ripostiglio' },
    { key: 'termoautonomo', label: 'Termoautonomo' },
    { key: 'portaBlindata', label: 'Porta Blindata' },
    { key: 'cappotto', label: 'Cappotto' },
    { key: 'cortilePrivato', label: 'Cortile Privato' },
  ].filter((caratteristica) => Boolean(immobile?.[caratteristica.key]))

  const indirizzoCompleto = [
    immobile?.via,
    immobile?.numeroCivico,
    immobile?.citta,
    immobile?.provincia,
    'Italia',
  ]
      .filter(Boolean)
      .join(', ')

  const mapsEmbedUrl = `https://www.google.com/maps?q=${encodeURIComponent(
      indirizzoCompleto
  )}&output=embed`

  const vaiAllaMappa = () => {
    const sezioneMappa = document.getElementById('mappa-immobile')

    if (sezioneMappa) {
      sezioneMappa.scrollIntoView({
        behavior: 'smooth',
        block: 'start',
      })
    }
  }

  const formatEnum = (valore) => {
    if (!valore) {
      return 'Non specificato'
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

  const formatTipi = (valore) => {
    if (!valore) {
      return 'Non specificato'
    }

    return valore
        .toString()
        .split(',')
        .map((tipo) => formatEnum(tipo.trim()))
        .join(', ')
  }

  if (loading) {
    return (
        <PublicLayout activePage="immobili">
          <div className="min-h-[400px] flex items-center justify-center">
            <p className="text-gray-600">Caricamento...</p>
          </div>
        </PublicLayout>
    )
  }

  if (!immobile) {
    return null
  }

  return (
      <PublicLayout activePage="immobili">
        <main className="max-w-6xl mx-auto px-4 py-8">
          <button
              type="button"
              onClick={() => navigate('/immobili')}
              className="flex items-center gap-2 text-blue-600 hover:text-blue-700 mb-6"
          >
            <ArrowLeft className="w-5 h-5" />
            Torna agli annunci
          </button>

          <div className="bg-white rounded-lg shadow-lg overflow-hidden">
            {/* Images Section */}
            <div className="relative bg-gray-100 min-h-[360px] md:min-h-[650px] flex items-center justify-center overflow-hidden">
              {fotoPrincipale ? (
                  <img
                      src={fotoPrincipale}
                      alt={immobile.titolo}
                      className="w-full h-full max-h-[420px] md:max-h-[650px] object-contain"
                  />
              ) : (
                  <div className="bg-gradient-to-r from-blue-400 to-indigo-400 w-full min-h-[360px] md:min-h-[650px] flex items-center justify-center">
                    <HomeIcon className="w-20 h-20 md:w-24 md:h-24 text-white" />
                  </div>
              )}

              {fotoDisponibili.length > 1 && (
                  <>
                    <button
                        type="button"
                        onClick={vaiFotoPrecedente}
                        className="absolute left-3 md:left-4 top-1/2 -translate-y-1/2 bg-black/50 text-white rounded-full p-2 hover:bg-black/70"
                    >
                      <ChevronLeft className="w-5 h-5 md:w-6 md:h-6" />
                    </button>

                    <button
                        type="button"
                        onClick={vaiFotoSuccessiva}
                        className="absolute right-3 md:right-4 top-1/2 -translate-y-1/2 bg-black/50 text-white rounded-full p-2 hover:bg-black/70"
                    >
                      <ChevronRight className="w-5 h-5 md:w-6 md:h-6" />
                    </button>

                    <div className="absolute bottom-4 right-4 bg-black/60 text-white text-sm px-3 py-1 rounded-full">
                      {fotoSelezionata + 1} / {fotoDisponibili.length}
                    </div>
                  </>
              )}
            </div>

            {/* Miniature foto */}
            {fotoDisponibili.length > 1 && (
                <div className="p-4 border-b bg-gray-50">
                  <div className="flex gap-3 overflow-x-auto">
                    {fotoDisponibili.map((foto, index) => (
                        <button
                            key={`${foto}-${index}`}
                            type="button"
                            onClick={() => setFotoSelezionata(index)}
                            className={`w-24 h-20 rounded-lg overflow-hidden border-2 flex-shrink-0 ${
                                fotoSelezionata === index
                                    ? 'border-blue-600'
                                    : 'border-transparent'
                            }`}
                        >
                          <img
                              src={getFotoUrl(foto)}
                              alt={`Foto ${index + 1}`}
                              className="w-full h-full object-cover"
                          />
                        </button>
                    ))}
                  </div>
                </div>
            )}

            {/* Details */}
            <div className="p-5 md:p-8">
              <h1 className="text-2xl md:text-4xl font-bold text-gray-800 mb-4">
                {immobile.titolo}
              </h1>

              {/* Location and Price */}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6 md:gap-8 mb-8">
                <div>
                  <button
                      type="button"
                      onClick={vaiAllaMappa}
                      className="flex items-center gap-2 text-gray-600 mb-4 text-base md:text-lg hover:text-blue-600 transition text-left"
                  >
                    <MapPin className="w-5 h-5 text-red-500 shrink-0" />

                    <span className="underline-offset-4 hover:underline">
                      {immobile.via || '-'}
                      {immobile.numeroCivico ? `, ${immobile.numeroCivico}` : ''}
                    </span>
                  </button>

                  <p className="text-gray-600 mb-2">
                    {immobile.citta}, {immobile.provincia || '-'}
                  </p>
                </div>

                <div>
                  <div className="flex items-center gap-2 text-3xl md:text-4xl font-bold text-blue-600">
                    <span>
                      {Number(immobile.prezzo).toLocaleString('it-IT')} €
                    </span>
                  </div>
                </div>
              </div>

              {/* Key Features */}
              <div className="grid grid-cols-2 md:grid-cols-5 gap-4 mb-8 pb-8 border-b">
                <div className="bg-gray-50 p-4 rounded-lg">
                  <div className="flex items-center gap-2 text-gray-600 mb-2">
                    <HomeIcon className="w-5 h-5" />
                    <span className="text-sm">Locali</span>
                  </div>

                  <p className="text-2xl font-bold text-gray-800">
                    {immobile.numeroLocali || '-'}
                  </p>
                </div>

                <div className="bg-gray-50 p-4 rounded-lg">
                  <div className="flex items-center gap-2 text-gray-600 mb-2">
                    <Droplet className="w-5 h-5" />
                    <span className="text-sm">Bagni</span>
                  </div>

                  <p className="text-2xl font-bold text-gray-800">
                    {immobile.numeroBagni || '-'}
                  </p>
                </div>

                <div className="bg-gray-50 p-4 rounded-lg">
                  <div className="flex items-center gap-2 text-gray-600 mb-2">
                    <HomeIcon className="w-5 h-5" />
                    <span className="text-sm">Camere</span>
                  </div>

                  <p className="text-2xl font-bold text-gray-800">
                    {immobile.camereDaLetto || '-'}
                  </p>
                </div>

                <div className="bg-gray-50 p-4 rounded-lg">
                  <div className="flex items-center gap-2 text-gray-600 mb-2">
                    <Ruler className="w-5 h-5" />
                    <span className="text-sm">Superficie</span>
                  </div>

                  <p className="text-2xl font-bold text-gray-800">
                    {immobile.superficieMq ? `${immobile.superficieMq} m²` : '-'}
                  </p>
                </div>

                <div className="bg-gray-50 p-4 rounded-lg">
                  <div className="flex items-center gap-2 text-gray-600 mb-2">
                    <Zap className="w-5 h-5" />
                    <span className="text-sm">Piano</span>
                  </div>

                  <p className="text-2xl font-bold text-gray-800">
                    {immobile.piano !== null && immobile.piano !== undefined
                        ? `${immobile.piano}°`
                        : '-'}
                  </p>
                </div>
              </div>

              {/* Additional Info */}
              <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-4 mb-8">
                <div>
                  <p className="text-gray-600 text-sm mb-1">Ubicazione</p>
                  <p className="font-semibold text-gray-800">
                    {formatEnum(immobile.ubicazione)}
                  </p>
                </div>

                <div>
                  <p className="text-gray-600 text-sm mb-1">Destinazione</p>
                  <p className="font-semibold text-gray-800">
                    {formatEnum(immobile.destinazione)}
                  </p>
                </div>

                <div>
                  <p className="text-gray-600 text-sm mb-1">Tipo</p>
                  <p className="font-semibold text-gray-800">
                    {formatTipi(immobile.tipo)}
                  </p>
                </div>

                <div>
                  <p className="text-gray-600 text-sm mb-1">Riscaldamento</p>
                  <p className="font-semibold text-gray-800">
                    {immobile.riscaldamento || 'Non specificato'}
                  </p>
                </div>
              </div>

              {/* Caratteristiche */}
              {caratteristiche.length > 0 && (
                  <div className="mb-8 pb-8 border-b">
                    <h2 className="text-2xl font-bold text-gray-800 mb-4">
                      Caratteristiche
                    </h2>

                    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-3">
                      {caratteristiche.map((caratteristica) => (
                          <div
                              key={caratteristica.key}
                              className="flex items-center gap-2 bg-green-50 text-green-800 px-4 py-3 rounded-lg font-semibold"
                          >
                            <span className="text-green-600">✓</span>
                            <span>{caratteristica.label}</span>
                          </div>
                      ))}
                    </div>
                  </div>
              )}

              {/* Description */}
              <div className="mb-8">
                <h2 className="text-2xl font-bold text-gray-800 mb-4">
                  Descrizione
                </h2>

                <p className="text-gray-700 leading-relaxed whitespace-pre-wrap">
                  {immobile.descrizione || 'Nessuna descrizione disponibile.'}
                </p>
              </div>

              {/* Mappa Immobile */}
              <div id="mappa-immobile" className="mb-8 pb-8 border-b scroll-mt-8">
                <div className="mb-4">
                  <h2 className="text-2xl font-bold text-gray-800">
                    Dov'è l'immobile
                  </h2>

                  <p className="text-sm text-gray-500 mt-1">
                    La posizione indicata sulla mappa può essere approssimativa.
                  </p>
                </div>

                <div className="mb-4">
                  <p className="text-gray-700 font-semibold">
                    {immobile.via || '-'}
                    {immobile.numeroCivico ? `, ${immobile.numeroCivico}` : ''}
                  </p>

                  <p className="text-gray-600">
                    {immobile.citta || '-'}
                    {immobile.provincia ? `, ${immobile.provincia}` : ''}
                  </p>
                </div>

                <div className="w-full h-[320px] md:h-[420px] rounded-xl overflow-hidden border border-gray-200 shadow-sm">
                  <iframe
                      title={`Mappa ${immobile.titolo}`}
                      src={mapsEmbedUrl}
                      width="100%"
                      height="100%"
                      style={{ border: 0 }}
                      loading="lazy"
                      referrerPolicy="no-referrer-when-downgrade"
                  />
                </div>
              </div>

              {/* Contact Section */}
              <div className="bg-blue-50 p-5 md:p-6 rounded-lg">
                <h3 className="text-lg font-bold text-gray-800 mb-4">
                  Interessato?
                </h3>

                <p className="text-gray-600 mb-4">
                  Contatta l'agenzia per ulteriori informazioni su questa
                  proprietà.
                </p>

                <Link
                    to="/contatti"
                    className="inline-block bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 font-semibold text-center"
                >
                  Contatta l'Agenzia
                </Link>
              </div>
            </div>
          </div>
        </main>
      </PublicLayout>
  )
}