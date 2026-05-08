import { Link } from 'react-router-dom'
import { LogIn, Phone, Mail, MapPin, Facebook, Instagram } from 'lucide-react'

export default function Contatti() {
  const token = localStorage.getItem('token')

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
              <Link to="/dashboard" className="hover:text-gray-300">Dashboard</Link>
            ) : (
              <Link to="/login" className="hover:text-gray-300 flex items-center gap-1">
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
            <Link to="/" className="text-gray-700 hover:text-blue-600 font-medium">Home</Link>
            <Link to="/immobili" className="text-gray-700 hover:text-blue-600 font-medium">Immobili</Link>
            <Link to="/contatti" className="text-blue-600 font-medium">Contatti</Link>
            <Link to="/servizi" className="text-gray-700 hover:text-blue-600 font-medium">Servizi</Link>
            <Link to="/agenzia" className="text-gray-700 hover:text-blue-600 font-medium">Agenzia</Link>
          </nav>
        </div>
      </header>

      {/* Main Content */}
      <div className="max-w-7xl mx-auto px-4 py-12">
        <h1 className="text-4xl font-bold text-gray-800 mb-6">Contatti</h1>
        
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
          <div className="bg-white p-6 rounded-lg shadow">
            <Phone className="w-8 h-8 text-blue-600 mb-3" />
            <h3 className="text-lg font-bold mb-2">Telefono</h3>
            <a href="tel:03723397" className="text-blue-600 hover:underline">0372 32397</a>
          </div>
          
          <div className="bg-white p-6 rounded-lg shadow">
            <Mail className="w-8 h-8 text-blue-600 mb-3" />
            <h3 className="text-lg font-bold mb-2">Email</h3>
            <a href="mailto:agenzia@ilmondoimmobiliare.eu" className="text-blue-600 hover:underline">agenzia@ilmondoimmobiliare.eu</a>
          </div>
          
          <div className="bg-white p-6 rounded-lg shadow">
            <MapPin className="w-8 h-8 text-blue-600 mb-3" />
            <h3 className="text-lg font-bold mb-2">Ubicazione</h3>
            <p className="text-gray-600">(In sviluppo...)</p>
          </div>
        </div>
      </div>
    </div>
  )
}
