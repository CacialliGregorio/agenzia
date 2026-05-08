import { useState, useEffect } from 'react'
import { useNavigate, Link } from 'react-router-dom'
import axiosInstance from '../api/axiosInstance'
import { LogOut, Plus, Edit, Trash2 } from 'lucide-react'
import ImmobileForm from '../components/ImmobileForm'

export default function Dashboard() {
  const navigate = useNavigate()
  const [immobili, setImmobili] = useState([])
  const [loading, setLoading] = useState(true)
  const [showForm, setShowForm] = useState(false)
  const [editingId, setEditingId] = useState(null)
  const [editingData, setEditingData] = useState(null)
  const userInfo = JSON.parse(localStorage.getItem('userInfo') || '{}')

  useEffect(() => {
    fetchMyImmobili()
  }, [])

  const fetchMyImmobili = async () => {
    setLoading(true)
    try {
      const response = await axiosInstance.get('/immobili', {
        params: { page: 0, size: 100 },
      })
      setImmobili(response.data.content)
    } catch (error) {
      console.error('Errore nel caricamento annunci:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleLogout = () => {
    localStorage.removeItem('token')
    localStorage.removeItem('userId')
    localStorage.removeItem('userInfo')
    navigate('/')
  }

  const handleDelete = async (id) => {
    if (window.confirm('Sei sicuro di voler eliminare questo annuncio?')) {
      try {
        await axiosInstance.delete(`/immobili/${id}`)
        setImmobili(immobili.filter((i) => i.id !== id))
      } catch (error) {
        alert('Errore nell\'eliminazione')
      }
    }
  }

  const handleFormSubmit = (data) => {
    if (editingId) {
      // Update
      axiosInstance
        .put(`/immobili/${editingId}`, data)
        .then(() => {
          fetchMyImmobili()
          setEditingId(null)
          setEditingData(null)
          setShowForm(false)
        })
        .catch(() => alert('Errore nell\'aggiornamento'))
    } else {
      // Create
      axiosInstance
        .post('/immobili', data)
        .then(() => {
          fetchMyImmobili()
          setShowForm(false)
        })
        .catch(() => alert('Errore nella creazione'))
    }
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Top Bar */}
      <div className="bg-gray-900 text-white text-sm py-2">
        <div className="max-w-7xl mx-auto px-4 flex justify-between items-center">
          <div className="flex gap-6">
            <a href="tel:03723397" className="hover:text-gray-300">📞 0372 32397</a>
            <a href="mailto:agenzia@ilmondoimmobiliare.eu" className="hover:text-gray-300">✉️ agenzia@ilmondoimmobiliare.eu</a>
          </div>
          <button
            onClick={handleLogout}
            className="hover:text-gray-300 flex items-center gap-1 text-red-400 hover:text-red-300"
          >
            <LogOut className="w-4 h-4" />
            Logout
          </button>
        </div>
      </div>

      {/* Header */}
      <header className="bg-white shadow-sm">
        <div className="max-w-7xl mx-auto px-4 py-4">
          <div className="flex justify-between items-start mb-4">
            <div>
              <img src="/logo.jpeg" alt="Agenzia Logo" className="h-12 w-auto mb-3" />
              <p className="text-gray-600">
                Benvenuto, {userInfo.nome} {userInfo.cognome}
              </p>
            </div>
          </div>
          <nav className="flex gap-6 border-t pt-3">
            <Link to="/" className="text-gray-700 hover:text-blue-600 font-medium">Home</Link>
            <Link to="/immobili" className="text-gray-700 hover:text-blue-600 font-medium">Immobili</Link>
            <Link to="/contatti" className="text-gray-700 hover:text-blue-600 font-medium">Contatti</Link>
            <Link to="/servizi" className="text-gray-700 hover:text-blue-600 font-medium">Servizi</Link>
            <Link to="/agenzia" className="text-gray-700 hover:text-blue-600 font-medium">Agenzia</Link>
          </nav>
        </div>
      </header>

      {/* Main Content */}
      <div className="max-w-7xl mx-auto px-4 py-8">
        {/* Form Section */}
        {showForm && (
          <div className="bg-white rounded-lg shadow-lg p-6 mb-8">
            <h2 className="text-2xl font-bold text-gray-800 mb-4">
              {editingId ? 'Modifica Annuncio' : 'Crea Nuovo Annuncio'}
            </h2>
            <ImmobileForm
              onSubmit={handleFormSubmit}
              initialData={editingData}
              onCancel={() => {
                setShowForm(false)
                setEditingId(null)
                setEditingData(null)
              }}
            />
          </div>
        )}

        {/* Create Button */}
        {!showForm && (
          <button
            onClick={() => setShowForm(true)}
            className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 flex items-center gap-2 mb-6 font-semibold"
          >
            <Plus className="w-5 h-5" />
            Nuovo Annuncio
          </button>
        )}

        {/* Annunci List */}
        <div className="bg-white rounded-lg shadow-lg">
          <div className="p-6">
            <h2 className="text-2xl font-bold text-gray-800 mb-4">
              I Miei Annunci ({immobili.length})
            </h2>

            {loading ? (
              <p className="text-gray-600">Caricamento...</p>
            ) : immobili.length === 0 ? (
              <p className="text-gray-600">Nessun annuncio creato</p>
            ) : (
              <div className="overflow-x-auto">
                <table className="w-full">
                  <thead className="bg-gray-100">
                    <tr>
                      <th className="px-4 py-2 text-left font-semibold text-gray-700">
                        Titolo
                      </th>
                      <th className="px-4 py-2 text-left font-semibold text-gray-700">
                        Città
                      </th>
                      <th className="px-4 py-2 text-left font-semibold text-gray-700">
                        Prezzo
                      </th>
                      <th className="px-4 py-2 text-left font-semibold text-gray-700">
                        Stato
                      </th>
                      <th className="px-4 py-2 text-center font-semibold text-gray-700">
                        Azioni
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    {immobili.map((immobile) => (
                      <tr key={immobile.id} className="border-b hover:bg-gray-50">
                        <td className="px-4 py-3 text-gray-800">{immobile.titolo}</td>
                        <td className="px-4 py-3 text-gray-600">{immobile.citta}</td>
                        <td className="px-4 py-3 font-semibold text-blue-600">
                          {immobile.prezzo.toLocaleString('it-IT')} €
                        </td>
                        <td className="px-4 py-3">
                          <span className="bg-green-100 text-green-800 px-2 py-1 rounded text-sm">
                            {immobile.stato}
                          </span>
                        </td>
                        <td className="px-4 py-3 text-center flex justify-center gap-2">
                          <button
                            onClick={() => {
                              setEditingId(immobile.id)
                              setEditingData(immobile)
                              setShowForm(true)
                            }}
                            className="p-2 text-blue-600 hover:bg-blue-50 rounded"
                          >
                            <Edit className="w-4 h-4" />
                          </button>
                          <button
                            onClick={() => handleDelete(immobile.id)}
                            className="p-2 text-red-600 hover:bg-red-50 rounded"
                          >
                            <Trash2 className="w-4 h-4" />
                          </button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}

