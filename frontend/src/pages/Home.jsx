import { useState, useEffect } from 'react'
import { useNavigate, Link } from 'react-router-dom'
import axiosInstance from '../api/axiosInstance'
import { Search, MapPin, DollarSign, Home as HomeIcon, LogIn, Plus, Facebook, Instagram } from 'lucide-react'
import SearchForm from '../components/SearchForm'

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
      {/* Top Bar */}
      <div className="bg-gray-900 text-white text-sm py-2">
        <div className="max-w-7xl mx-auto px-4 flex justify-between items-center">
          <div className="flex gap-4 items-center">
            <a href="https://www.facebook.com/ILMONDOIMMOBILIARECR" target="_blank" rel="noopener noreferrer" className="bg-white rounded-lg p-1.5 flex items-center justify-center hover:bg-blue-100 transition">
              <Facebook className="w-5 h-5 text-blue-600" />
            </a>
            <a href="https://www.instagram.com/ilmondoimmobiliare/" target="_blank" rel="noopener noreferrer" className="bg-white rounded-lg p-1.5 flex items-center justify-center hover:bg-pink-100 transition">
              <Instagram className="w-5 h-5 text-pink-500" />
            </a>
            <span className="mx-2 h-5 w-px bg-gray-400 inline-block"></span>
            <a href="tel:03723397" className="hover:text-gray-300">📞 0372 32397</a>
            <a href="mailto:agenzia@ilmondoimmobiliare.eu" className="hover:text-gray-300">✉️ agenzia@ilmondoimmobiliare.eu</a>
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
      <header className="bg-white shadow-sm sticky top-0 z-10">
        <div className="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
          <div className="flex items-center gap-2">
            <img src="/logo.jpeg" alt="Agenzia Logo" className="h-12 w-auto" />
          </div>
          <nav className="flex gap-6">
            <Link to="/" className="text-blue-600 font-medium">Home</Link>
            <Link to="/immobili" className="text-gray-700 hover:text-blue-600 font-medium">Immobili</Link>
            <Link to="/contatti" className="text-gray-700 hover:text-blue-600 font-medium">Contatti</Link>
            <Link to="/servizi" className="text-gray-700 hover:text-blue-600 font-medium">Servizi</Link>
            <Link to="/agenzia" className="text-gray-700 hover:text-blue-600 font-medium">Agenzia</Link>
          </nav>
        </div>
      </header>

      {/* Hero + Search */}
      <SearchForm />

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

      <section className="bg-green-500 text-white">
        <div className="max-w-7xl mx-auto px-4 py-12">
          <div className="grid grid-cols-1 gap-10 md:grid-cols-3">
            <div>
              <h2 className="text-2xl font-bold mb-6">Il Mondo Immobiliare</h2>
              <p className="text-lg leading-8">
                L'agenzia “Il Mondo Immobiliare” offre alla propria clientela un insieme di
                servizi integrati in grado di soddisfare tutte le esigenze di chi compra,
                vende, affitta o ricerca un immobile.
              </p>
            </div>

            <div className="text-center">
              <h2 className="text-2xl font-bold mb-6">F.I.M.A.A.</h2>
              <img
                src="/fimaa.jpg"
                alt="F.I.M.A.A."
                className="mx-auto max-h-32 w-auto"
              />
            </div>

            <div></div>
          </div>
        </div>
      </section>
    </div>
  )
}
