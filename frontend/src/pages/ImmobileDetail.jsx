import { useState, useEffect } from 'react'
import { useParams, useNavigate, Link } from 'react-router-dom'
import axiosInstance from '../api/axiosInstance'
import {
  ArrowLeft,
  MapPin,
  DollarSign,
  Ruler,
  Home as HomeIcon,
  Droplet,
  Zap,
  LogIn,
  ChevronLeft,
  ChevronRight,
} from 'lucide-react'
import WhatsAppTopLink from '../components/WhatsAppTopLink'
const BACKEND_URL = 'http://localhost:8080'

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
  const fotoPrincipale = fotoDisponibili.length > 0
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

  if (loading) {
    return (
        <div className="min-h-screen flex items-center justify-center">
          <p className="text-gray-600">Caricamento...</p>
        </div>
    )
  }

  if (!immobile) {
    return null
  }

  return (
      <div className="min-h-screen bg-gray-50">
        {/* Top Bar */}
        <div className="bg-gray-900 text-white text-sm py-2">
          <div className="max-w-6xl mx-auto px-4 flex justify-between items-center">
            <div className="flex gap-6">
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
              <button
                  onClick={() => navigate('/login')}
                  className="hover:text-gray-300 flex items-center gap-1"
              >
                <LogIn className="w-4 h-4" />
                Area Dipendenti
              </button>
            </div>
          </div>
        </div>

        {/* Header */}
        <header className="bg-white shadow-sm">
          <div className="max-w-6xl mx-auto px-4 py-4">
            <div className="mb-4">
              <img src="/logo.jpeg" alt="Agenzia Logo" className="h-12 w-auto" />
            </div>

            <nav className="flex gap-6 mb-4">
              <Link to="/" className="text-gray-700 hover:text-blue-600 font-medium">
                Home
              </Link>

              <Link to="/immobili" className="text-blue-600 font-medium">
                Immobili
              </Link>

              <Link to="/contatti" className="text-gray-700 hover:text-blue-600 font-medium">
                Contatti
              </Link>

              <Link to="/servizi" className="text-gray-700 hover:text-blue-600 font-medium">
                Servizi
              </Link>

              <Link to="/agenzia" className="text-gray-700 hover:text-blue-600 font-medium">
                Agenzia
              </Link>
            </nav>

            <button
                onClick={() => navigate('/immobili')}
                className="flex items-center gap-2 text-blue-600 hover:text-blue-700 mb-4"
            >
              <ArrowLeft className="w-5 h-5" />
              Torna agli annunci
            </button>
          </div>
        </header>

        {/* Main Content */}
        <div className="max-w-6xl mx-auto px-4 py-8">
          <div className="bg-white rounded-lg shadow-lg overflow-hidden">
            {/* Images Section */}
            <div className="relative bg-gray-200 h-96 flex items-center justify-center overflow-hidden">
              {fotoPrincipale ? (
                  <img
                      src={fotoPrincipale}
                      alt={immobile.titolo}
                      className="w-full h-full object-cover"
                  />
              ) : (
                  <div className="bg-gradient-to-r from-blue-400 to-indigo-400 w-full h-full flex items-center justify-center">
                    <HomeIcon className="w-24 h-24 text-white" />
                  </div>
              )}

              {fotoDisponibili.length > 1 && (
                  <>
                    <button
                        type="button"
                        onClick={vaiFotoPrecedente}
                        className="absolute left-4 top-1/2 -translate-y-1/2 bg-black/50 text-white rounded-full p-2 hover:bg-black/70"
                    >
                      <ChevronLeft className="w-6 h-6" />
                    </button>

                    <button
                        type="button"
                        onClick={vaiFotoSuccessiva}
                        className="absolute right-4 top-1/2 -translate-y-1/2 bg-black/50 text-white rounded-full p-2 hover:bg-black/70"
                    >
                      <ChevronRight className="w-6 h-6" />
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
            <div className="p-8">
              <h1 className="text-4xl font-bold text-gray-800 mb-4">
                {immobile.titolo}
              </h1>

              {/* Location and Price */}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-8">
                <div>
                  <div className="flex items-center gap-2 text-gray-600 mb-4 text-lg">
                    <MapPin className="w-5 h-5 text-red-500" />
                    <span>
                    {immobile.via || '-'}, {immobile.numeroCivico || '-'}
                  </span>
                  </div>

                  <p className="text-gray-600 mb-2">
                    {immobile.citta}, {immobile.provincia || '-'}
                  </p>
                </div>

                <div>
                  <div className="flex items-center gap-2 text-4xl font-bold text-blue-600">
                    <DollarSign className="w-8 h-8" />
                    <span>
                    {Number(immobile.prezzo).toLocaleString('it-IT')} €
                  </span>
                  </div>
                </div>
              </div>

              {/* Key Features */}
              <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8 pb-8 border-b">
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
              <div className="grid grid-cols-2 md:grid-cols-3 gap-4 mb-8">
                <div>
                  <p className="text-gray-600 text-sm mb-1">Tipo</p>
                  <p className="font-semibold text-gray-800">{immobile.tipo}</p>
                </div>

                <div>
                  <p className="text-gray-600 text-sm mb-1">Ascensore</p>
                  <p className="font-semibold text-gray-800">
                    {immobile.ascensore ? 'Sì' : 'No'}
                  </p>
                </div>

                <div>
                  <p className="text-gray-600 text-sm mb-1">Riscaldamento</p>
                  <p className="font-semibold text-gray-800">
                    {immobile.riscaldamento || 'Non specificato'}
                  </p>
                </div>
              </div>

              {/* Description */}
              <div className="mb-8">
                <h2 className="text-2xl font-bold text-gray-800 mb-4">
                  Descrizione
                </h2>

                <p className="text-gray-700 leading-relaxed whitespace-pre-wrap">
                  {immobile.descrizione || 'Nessuna descrizione disponibile.'}
                </p>
              </div>

              {/* Contact Section */}
              <div className="bg-blue-50 p-6 rounded-lg">
                <h3 className="text-lg font-bold text-gray-800 mb-4">
                  Interessato?
                </h3>

                <p className="text-gray-600 mb-4">
                  Contatta l'agenzia per ulteriori informazioni su questa proprietà.
                </p>

                <Link
                    to="/contatti"
                    className="inline-block bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 font-semibold"
                >
                  Contatta l'Agenzia
                </Link>
              </div>
            </div>
          </div>
        </div>
      </div>
  )
}