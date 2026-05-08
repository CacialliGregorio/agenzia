import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import axiosInstance from '../api/axiosInstance'
import { ArrowLeft, MapPin, DollarSign, Ruler, Home as HomeIcon, Droplet, Zap } from 'lucide-react'

export default function ImmobileDetail() {
  const { id } = useParams()
  const navigate = useNavigate()
  const [immobile, setImmobile] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetchImmobile()
  }, [id])

  const fetchImmobile = async () => {
    try {
      const response = await axiosInstance.get(`/immobili/${id}`)
      setImmobile(response.data)
    } catch (error) {
      console.error('Errore nel caricamento immobile:', error)
      navigate('/')
    } finally {
      setLoading(false)
    }
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
      {/* Header */}
      <header className="bg-white shadow-sm">
        <div className="max-w-6xl mx-auto px-4 py-4">
          <button
            onClick={() => navigate('/')}
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
          <div className="bg-gradient-to-r from-blue-400 to-indigo-400 h-96 flex items-center justify-center">
            <HomeIcon className="w-24 h-24 text-white" />
          </div>

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
                  <span>{immobile.via}, {immobile.numeroCivico}</span>
                </div>
                <p className="text-gray-600 mb-2">
                  {immobile.citta}, {immobile.provincia}
                </p>
              </div>

              <div>
                <div className="flex items-center gap-2 text-4xl font-bold text-blue-600">
                  <DollarSign className="w-8 h-8" />
                  <span>{immobile.prezzo.toLocaleString('it-IT')} €</span>
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
                  {immobile.superficieMq} m²
                </p>
              </div>

              <div className="bg-gray-50 p-4 rounded-lg">
                <div className="flex items-center gap-2 text-gray-600 mb-2">
                  <Zap className="w-5 h-5" />
                  <span className="text-sm">Piano</span>
                </div>
                <p className="text-2xl font-bold text-gray-800">
                  {immobile.piano !== null ? `${immobile.piano}°` : '-'}
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
              <h2 className="text-2xl font-bold text-gray-800 mb-4">Descrizione</h2>
              <p className="text-gray-700 leading-relaxed whitespace-pre-wrap">
                {immobile.descrizione}
              </p>
            </div>

            {/* Contact Section */}
            <div className="bg-blue-50 p-6 rounded-lg">
              <h3 className="text-lg font-bold text-gray-800 mb-4">Interessato?</h3>
              <p className="text-gray-600 mb-4">
                Contatta l'agenzia per ulteriori informazioni su questa proprietà
              </p>
              <button className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 font-semibold">
                Contatta l'Agenzia
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

