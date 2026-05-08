import { useState, useEffect } from 'react'
import { useNavigate, Link } from 'react-router-dom'
import axiosInstance from '../api/axiosInstance'
import { Search, MapPin, DollarSign, Home as HomeIcon, LogIn, Plus } from 'lucide-react'

export default function Home() {
  const [immobili, setImmobili] = useState([])
  const [loading, setLoading] = useState(true)
  const [searchParams, setSearchParams] = useState({
    citta: '',
    tipo: '',
    prezzoMin: '',
    prezzoMax: '',
  })
  const [page, setPage] = useState(0)
  const navigate = useNavigate()
  const token = localStorage.getItem('token')

  useEffect(() => {
    fetchImmobili()
  }, [page, searchParams])

  const fetchImmobili = async () => {
    setLoading(true)
    try {
      const response = await axiosInstance.get('/immobili/cerca', {
        params: {
          ...searchParams,
          page,
          size: 12,
        },
      })
      setImmobili(response.data.content)
    } catch (error) {
      console.error('Errore nel caricamento annunci:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleSearch = (e) => {
    e.preventDefault()
    setPage(0)
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white shadow-sm sticky top-0 z-10">
        <div className="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
          <div className="flex items-center gap-2">
            <HomeIcon className="w-8 h-8 text-blue-600" />
            <h1 className="text-2xl font-bold text-gray-800">Agenzia Immobiliare</h1>
          </div>
          <div className="flex gap-4">
            {token ? (
              <Link
                to="/dashboard"
                className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 flex items-center gap-2"
              >
                <Plus className="w-4 h-4" />
                Nuovi Annunci
              </Link>
            ) : (
              <button
                onClick={() => navigate('/login')}
                className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 flex items-center gap-2"
              >
                <LogIn className="w-4 h-4" />
                Area Dipendenti
              </button>
            )}
          </div>
        </div>
      </header>

      {/* Hero + Search */}
      <section className="bg-gradient-to-r from-blue-600 to-indigo-600 text-white py-12">
        <div className="max-w-7xl mx-auto px-4">
          <h2 className="text-4xl font-bold mb-2">Trova la Tua Casa Ideale</h2>
          <p className="text-blue-100 mb-8">Migliaia di proprietà disponibili</p>

          <form onSubmit={handleSearch} className="bg-white rounded-lg shadow-lg p-6 text-gray-800">
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-4 mb-4">
              <input
                type="text"
                placeholder="Città"
                value={searchParams.citta}
                onChange={(e) => setSearchParams({ ...searchParams, citta: e.target.value })}
                className="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
              />
              <select
                value={searchParams.tipo}
                onChange={(e) => setSearchParams({ ...searchParams, tipo: e.target.value })}
                className="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
              >
                <option value="">Tipo</option>
                <option value="CASA">Casa</option>
                <option value="APPARTAMENTO">Appartamento</option>
                <option value="VILLA">Villa</option>
                <option value="TERRENO">Terreno</option>
              </select>
              <input
                type="number"
                placeholder="Prezzo Min"
                value={searchParams.prezzoMin}
                onChange={(e) => setSearchParams({ ...searchParams, prezzoMin: e.target.value })}
                className="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
              />
              <input
                type="number"
                placeholder="Prezzo Max"
                value={searchParams.prezzoMax}
                onChange={(e) => setSearchParams({ ...searchParams, prezzoMax: e.target.value })}
                className="px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
              />
              <button
                type="submit"
                className="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 flex items-center justify-center gap-2"
              >
                <Search className="w-4 h-4" />
                Cerca
              </button>
            </div>
          </form>
        </div>
      </section>

      {/* Annunci Grid */}
      <section className="max-w-7xl mx-auto px-4 py-12">
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
            {immobili.map((immobile) => (
              <Link
                key={immobile.id}
                to={`/annuncio/${immobile.id}`}
                className="bg-white rounded-lg shadow-md hover:shadow-xl transition-shadow overflow-hidden"
              >
                <div className="bg-gradient-to-r from-blue-400 to-indigo-400 h-48 flex items-center justify-center">
                  <HomeIcon className="w-12 h-12 text-white" />
                </div>
                <div className="p-4">
                  <h3 className="font-bold text-lg text-gray-800 mb-2 line-clamp-2">
                    {immobile.titolo}
                  </h3>
                  <div className="flex items-center gap-2 text-gray-600 mb-2">
                    <MapPin className="w-4 h-4" />
                    <span>{immobile.citta}, {immobile.provincia}</span>
                  </div>
                  <div className="flex items-center gap-2 text-blue-600 font-bold">
                    <DollarSign className="w-4 h-4" />
                    <span>{immobile.prezzo.toLocaleString('it-IT')} €</span>
                  </div>
                  <div className="text-sm text-gray-500 mt-3 pt-3 border-t">
                    {immobile.numeroLocali} locali · {immobile.superficieMq} m²
                  </div>
                </div>
              </Link>
            ))}
          </div>
        )}
      </section>
    </div>
  )
}

