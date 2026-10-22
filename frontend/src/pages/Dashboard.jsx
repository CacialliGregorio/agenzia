import { useState, useEffect } from 'react'
import { useNavigate, Link } from 'react-router-dom'
import axiosInstance from '../api/axiosInstance'
import {
  LogOut,
  Plus,
  Edit,
  Eye,
  Trash2,
  StickyNote,
  Save,
  Image,
} from 'lucide-react'
import ImmobileForm from '../components/ImmobileForm'
import { useToast } from '../context/ToastContext'

export default function Dashboard() {
  const navigate = useNavigate()
  const { success, error } = useToast()

  const [immobili, setImmobili] = useState([])
  const [loading, setLoading] = useState(true)

  // Ricerca e ordinamento per codice riferimento immobile
  const [searchId, setSearchId] = useState('')
  const [ordinamento, setOrdinamento] = useState('id-desc')

  const [showForm, setShowForm] = useState(false)
  const [editingId, setEditingId] = useState(null)
  const [editingData, setEditingData] = useState(null)
  const [saving, setSaving] = useState(false)

  const [showSlideManager, setShowSlideManager] = useState(false)
  const [slideCodici, setSlideCodici] = useState(['', '', ''])
  const [slideSaving, setSlideSaving] = useState(false)

  const [selectedNoteId, setSelectedNoteId] = useState(null)
  const [selectedNoteImmobile, setSelectedNoteImmobile] = useState(null)
  const [noteText, setNoteText] = useState('')
  const [noteLoading, setNoteLoading] = useState(false)
  const [noteSaving, setNoteSaving] = useState(false)

  const userInfo = JSON.parse(localStorage.getItem('userInfo') || '{}')

  useEffect(() => {
    fetchMyImmobili()
  }, [])

  const fetchMyImmobili = async () => {
    setLoading(true)

    try {
      const response = await axiosInstance.get('/admin/immobili', {
        params: {
          page: 0,
          size: 100,
        },
      })

      setImmobili(response.data.content || [])
    } catch (err) {
      console.error('Errore nel caricamento annunci:', err)
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

  const resetSezioniAperte = () => {
    setSelectedNoteId(null)
    setSelectedNoteImmobile(null)
    setNoteText('')
    setShowSlideManager(false)
  }

  const handleCreate = () => {
    resetSezioniAperte()
    setEditingId(null)
    setEditingData(null)
    setShowForm(true)
  }

  const handleEdit = async (id) => {
    try {
      const response = await axiosInstance.get(`/immobili/${id}`)

      setEditingId(id)
      setEditingData(response.data)
      setSelectedNoteId(null)
      setSelectedNoteImmobile(null)
      setNoteText('')
      setShowSlideManager(false)
      setShowForm(true)

      setTimeout(() => {
        window.scrollTo({
          top: 0,
          behavior: 'smooth',
        })
      }, 100)
    } catch (err) {
      console.error('Errore nel caricamento immobile da modificare:', err)

      error(
          'Errore nel caricamento',
          "Impossibile caricare l'annuncio da modificare. Riprova."
      )
    }
  }

  const handleDelete = async (id) => {
    if (!window.confirm('Sei sicuro di voler eliminare questo annuncio?')) {
      return
    }

    try {
      await axiosInstance.delete(`/immobili/${id}`)

      setImmobili((prev) =>
          prev.filter((immobile) => immobile.id !== id)
      )

      if (selectedNoteId === id) {
        handleCloseNote()
      }

      success(
          'Annuncio eliminato',
          "L'immobile è stato eliminato correttamente."
      )
    } catch (err) {
      console.error("Errore nell'eliminazione:", err)

      error(
          "Errore nell'eliminazione",
          "Impossibile eliminare l'annuncio. Riprova."
      )
    }
  }

  const uploadFoto = async (immobileId, fotoFiles) => {
    if (!fotoFiles || fotoFiles.length === 0) {
      return
    }

    const formData = new FormData()

    fotoFiles.forEach((file) => {
      formData.append('files', file)
    })

    await axiosInstance.post(`/immobili/${immobileId}/foto`, formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    })
  }

  const handleFormSubmit = async (data, fotoFiles) => {
    setSaving(true)

    const isModifica = Boolean(editingId)

    try {
      if (editingId) {
        await axiosInstance.put(`/immobili/${editingId}`, data)

        if (fotoFiles && fotoFiles.length > 0) {
          await uploadFoto(editingId, fotoFiles)
        }
      } else {
        const response = await axiosInstance.post('/immobili', data)
        const nuovoImmobile = response.data

        if (fotoFiles && fotoFiles.length > 0) {
          await uploadFoto(nuovoImmobile.id, fotoFiles)
        }
      }

      await fetchMyImmobili()

      setEditingId(null)
      setEditingData(null)
      setShowForm(false)

      if (isModifica) {
        success(
            'Annuncio aggiornato',
            "Le modifiche all'immobile sono state salvate correttamente."
        )
      } else {
        success(
            'Annuncio creato',
            "L'immobile è stato salvato correttamente."
        )
      }
    } catch (err) {
      console.error('Errore nel salvataggio annuncio:', err)

      error(
          'Errore nel salvataggio',
          "Impossibile salvare l'annuncio o le immagini. Riprova."
      )
    } finally {
      setSaving(false)
    }
  }

  const handleOpenSlideManager = async () => {
    setShowForm(false)
    setEditingId(null)
    setEditingData(null)
    setSelectedNoteId(null)
    setSelectedNoteImmobile(null)
    setNoteText('')
    setShowSlideManager(true)

    try {
      const response = await axiosInstance.get('/admin/immobili/slide')

      const codici = (response.data || []).map(
          (immobile) => immobile.codiceRiferimento || ''
      )

      setSlideCodici([
        codici[0] || '',
        codici[1] || '',
        codici[2] || '',
      ])

      setTimeout(() => {
        const sezione = document.getElementById('slide-manager-section')

        if (sezione) {
          sezione.scrollIntoView({
            behavior: 'smooth',
            block: 'start',
          })
        }
      }, 100)
    } catch (err) {
      console.error('Errore caricamento slide:', err)

      error(
          'Errore nel caricamento',
          'Impossibile caricare gli immobili attualmente presenti nella slide.'
      )
    }
  }

  const handleChangeSlideCodice = (index, value) => {
    setSlideCodici((codiciCorrenti) =>
        codiciCorrenti.map((codice, posizione) =>
            posizione === index ? value : codice
        )
    )
  }

  const handleSaveSlide = async () => {
    const codiciPuliti = slideCodici
        .map((codice) => codice.trim())
        .filter(Boolean)

    if (codiciPuliti.length !== 3) {
      error(
          'Selezione incompleta',
          'Inserisci esattamente 3 codici riferimento.'
      )
      return
    }

    if (new Set(codiciPuliti).size !== 3) {
      error(
          'Codici duplicati',
          'I 3 codici riferimento devono essere diversi tra loro.'
      )
      return
    }

    setSlideSaving(true)

    try {
      await axiosInstance.put('/admin/immobili/slide', {
        codiciRiferimento: codiciPuliti,
      })

      success(
          'Slide aggiornata',
          'I 3 immobili selezionati sono ora impostati nella slide della Home.'
      )

      setShowSlideManager(false)
      await fetchMyImmobili()
    } catch (err) {
      console.error('Errore salvataggio slide:', err)

      error(
          'Errore nel salvataggio',
          'Controlla che i 3 codici riferimento esistano e che gli immobili siano disponibili.'
      )
    } finally {
      setSlideSaving(false)
    }
  }

  const handleCloseSlideManager = () => {
    setShowSlideManager(false)
    setSlideCodici(['', '', ''])
  }

  const handleOpenNote = async (immobile) => {
    setShowForm(false)
    setEditingId(null)
    setEditingData(null)
    setShowSlideManager(false)

    setSelectedNoteId(immobile.id)
    setSelectedNoteImmobile(immobile)
    setNoteLoading(true)

    try {
      const response = await axiosInstance.get(
          `/admin/immobili/${immobile.id}/note`
      )

      setNoteText(response.data.notePrivate || '')

      setTimeout(() => {
        const noteSection = document.getElementById('note-private-section')

        if (noteSection) {
          noteSection.scrollIntoView({
            behavior: 'smooth',
            block: 'start',
          })
        }
      }, 100)
    } catch (err) {
      console.error('Errore caricamento note private:', err)

      error(
          'Errore nel caricamento',
          'Impossibile caricare le note private di questo immobile.'
      )
    } finally {
      setNoteLoading(false)
    }
  }

  const handleSaveNote = async () => {
    if (!selectedNoteId) {
      return
    }

    setNoteSaving(true)

    try {
      await axiosInstance.put(`/admin/immobili/${selectedNoteId}/note`, {
        notePrivate: noteText,
      })

      success(
          'Note salvate',
          'Le note private sono state aggiornate correttamente.'
      )
    } catch (err) {
      console.error('Errore salvataggio note private:', err)

      error(
          'Errore nel salvataggio',
          'Impossibile salvare le note private. Riprova.'
      )
    } finally {
      setNoteSaving(false)
    }
  }

  const handleCloseNote = () => {
    setSelectedNoteId(null)
    setSelectedNoteImmobile(null)
    setNoteText('')
  }

  const handleCancelForm = () => {
    setShowForm(false)
    setEditingId(null)
    setEditingData(null)
  }

  const getStatoClassName = (stato) => {
    if (stato === 'DISPONIBILE') {
      return 'bg-green-100 text-green-800'
    }

    if (stato === 'VENDUTO') {
      return 'bg-red-100 text-red-800'
    }

    if (stato === 'AFFITTATO') {
      return 'bg-yellow-100 text-yellow-800'
    }

    return 'bg-gray-100 text-gray-800'
  }

  const getStatoLabel = (stato) => {
    if (stato === 'DISPONIBILE') {
      return 'DISPONIBILE'
    }

    if (stato === 'VENDUTO') {
      return 'VENDUTO'
    }

    if (stato === 'AFFITTATO') {
      return 'AFFITTATO'
    }

    return stato || '-'
  }

  /*
   * IMPORTANTE:
   * la Dashboard usa come ID visibile il codice riferimento
   * inserito manualmente quando viene creato l'annuncio.
   *
   * L'id tecnico del database continua invece ad essere utilizzato
   * internamente per modifica, eliminazione, note e visualizzazione.
   */
  const immobiliVisualizzati = [...immobili]
      .filter((immobile) => {
        if (!searchId.trim()) {
          return true
        }

        return String(immobile.codiceRiferimento || '') === searchId.trim()
      })
      .sort((a, b) => {
        if (ordinamento === 'prezzo-asc') {
          return Number(a.prezzo || 0) - Number(b.prezzo || 0)
        }

        if (ordinamento === 'prezzo-desc') {
          return Number(b.prezzo || 0) - Number(a.prezzo || 0)
        }

        const idA = Number(a.codiceRiferimento) || 0
        const idB = Number(b.codiceRiferimento) || 0

        if (ordinamento === 'id-asc') {
          return idA - idB
        }

        return idB - idA
      })

  return (
      <div className="min-h-screen bg-gray-50">
        {/* Top Bar */}
        <div className="bg-gray-900 text-white text-sm py-2">
          <div className="max-w-7xl mx-auto px-4 flex justify-between items-center">
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

            <button
                type="button"
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
                <button
                    type="button"
                    onClick={() =>
                        window.scrollTo({
                          top: 0,
                          behavior: 'smooth',
                        })
                    }
                    className="cursor-pointer"
                    aria-label="Torna in cima alla pagina"
                >
                  <img
                      src="/logo.jpeg"
                      alt="Agenzia Logo"
                      className="h-12 w-auto mb-3"
                  />
                </button>

                <p className="text-gray-600">
                  Benvenuto, {userInfo.nome} {userInfo.cognome}
                </p>
              </div>
            </div>

            <nav className="flex gap-6 border-t pt-3">
              <Link
                  to="/"
                  className="text-gray-700 hover:text-blue-600 font-medium"
              >
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

        {/* Main Content */}
        <div className="max-w-7xl mx-auto px-4 py-8">
          {/* Form Section */}
          {showForm && (
              <div className="bg-white rounded-lg shadow-lg p-6 mb-8">
                <h2 className="text-2xl font-bold text-gray-800 mb-4">
                  {editingId ? 'Modifica Annuncio' : 'Crea Nuovo Annuncio'}
                </h2>

                {saving && (
                    <div className="mb-4 bg-blue-50 text-blue-700 border border-blue-200 px-4 py-3 rounded-lg">
                      Salvataggio in corso...
                    </div>
                )}

                <ImmobileForm
                    key={editingId || 'nuovo-annuncio'}
                    onSubmit={handleFormSubmit}
                    initialData={editingData}
                    onCancel={handleCancelForm}
                />
              </div>
          )}

          {/* Pulsanti principali */}
          {!showForm && (
              <div className="flex flex-wrap gap-3 mb-6">
                <button
                    type="button"
                    onClick={handleCreate}
                    className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 flex items-center gap-2 font-semibold"
                >
                  <Plus className="w-5 h-5" />
                  Nuovo Annuncio
                </button>

                <button
                    type="button"
                    onClick={handleOpenSlideManager}
                    className="bg-green-600 text-white px-6 py-3 rounded-lg hover:bg-green-700 flex items-center gap-2 font-semibold"
                >
                  <Image className="w-5 h-5" />
                  Gestisci Slide
                </button>
              </div>
          )}

          {/* Gestione slide */}
          {showSlideManager && (
              <div
                  id="slide-manager-section"
                  className="bg-white rounded-lg shadow-lg p-6 mb-8 border border-green-200"
              >
                <div className="flex items-start justify-between gap-4 mb-4">
                  <div>
                    <h2 className="text-2xl font-bold text-gray-800">
                      Gestisci immobili nella slide
                    </h2>

                    <p className="text-gray-600 mt-1">
                      Inserisci i 3 codici riferimento degli immobili disponibili da
                      mostrare nella slide della Home.
                    </p>

                    <p className="text-sm text-gray-500 mt-2">
                      Usa il codice riferimento che hai inserito nell'annuncio, ad
                      esempio 1807, 1813 o 1785. Non usare l'ID tecnico del database.
                    </p>
                  </div>

                  <button
                      type="button"
                      onClick={handleCloseSlideManager}
                      className="text-gray-500 hover:text-gray-800 font-semibold"
                  >
                    Chiudi
                  </button>
                </div>

                <div className="grid md:grid-cols-3 gap-4">
                  {[0, 1, 2].map((index) => (
                      <div key={index}>
                        <label className="block text-sm font-medium text-gray-700 mb-1">
                          Codice riferimento slide {index + 1}
                        </label>

                        <input
                            type="text"
                            value={slideCodici[index]}
                            onChange={(e) =>
                                handleChangeSlideCodice(index, e.target.value)
                            }
                            placeholder="Es: 1807"
                            className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:outline-none"
                        />
                      </div>
                  ))}
                </div>

                <div className="flex gap-4 mt-6">
                  <button
                      type="button"
                      onClick={handleSaveSlide}
                      disabled={slideSaving}
                      className="bg-green-600 text-white px-6 py-3 rounded-lg hover:bg-green-700 font-semibold flex items-center gap-2 disabled:bg-gray-300"
                  >
                    <Save className="w-5 h-5" />
                    {slideSaving ? 'Salvataggio...' : 'Salva slide'}
                  </button>

                  <button
                      type="button"
                      onClick={handleCloseSlideManager}
                      className="bg-gray-200 text-gray-800 px-6 py-3 rounded-lg hover:bg-gray-300 font-semibold"
                  >
                    Annulla
                  </button>
                </div>
              </div>
          )}

          {/* Annunci List */}
          <div className="bg-white rounded-lg shadow-lg">
            <div className="p-6">
              <h2 className="text-2xl font-bold text-gray-800 mb-2">
                I Miei Annunci ({immobili.length})
              </h2>

              <p className="text-sm text-gray-500 mb-4">
                In questa tabella vedi anche gli immobili venduti o affittati. Nel
                sito pubblico vengono mostrati solo quelli disponibili.
              </p>

              {/* Ricerca e ordinamento per ID commerciale */}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                <div>
                  <label
                      htmlFor="search-id"
                      className="block text-sm font-medium text-gray-700 mb-1"
                  >
                    Cerca per ID
                  </label>

                  <input
                      id="search-id"
                      type="number"
                      min="1"
                      value={searchId}
                      onChange={(e) => setSearchId(e.target.value)}
                      placeholder="Es. 1813"
                      className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none"
                  />
                </div>

                <div>
                  <label
                      htmlFor="ordinamento"
                      className="block text-sm font-medium text-gray-700 mb-1"
                  >
                    Ordina immobili
                  </label>

                  <select
                      id="ordinamento"
                      value={ordinamento}
                      onChange={(e) => setOrdinamento(e.target.value)}
                      className="w-full px-4 py-3 border border-gray-300 rounded-lg bg-white focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none"
                  >
                    <option value="id-desc">ID decrescente</option>
                    <option value="id-asc">ID crescente</option>
                    <option value="prezzo-asc">Prezzo crescente</option>
                    <option value="prezzo-desc">Prezzo decrescente</option>
                  </select>
                </div>
              </div>

              {loading ? (
                  <p className="text-gray-600">Caricamento...</p>
              ) : immobili.length === 0 ? (
                  <p className="text-gray-600">Nessun annuncio creato</p>
              ) : immobiliVisualizzati.length === 0 ? (
                  <div className="bg-gray-50 border border-gray-200 rounded-lg px-4 py-6 text-center">
                    <p className="text-gray-600 font-medium">
                      Nessun immobile trovato con questo ID.
                    </p>

                    <button
                        type="button"
                        onClick={() => setSearchId('')}
                        className="mt-3 text-blue-600 hover:text-blue-700 font-semibold"
                    >
                      Mostra tutti gli annunci
                    </button>
                  </div>
              ) : (
                  <div className="overflow-x-auto">
                    <table className="w-full">
                      <thead className="bg-gray-100">
                      <tr>
                        <th className="px-4 py-2 text-left font-semibold text-gray-700">
                          ID
                        </th>

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
                      {immobiliVisualizzati.map((immobile) => (
                          <tr
                              key={immobile.id}
                              className="border-b hover:bg-gray-50"
                          >
                            <td className="px-4 py-3 text-gray-600 font-semibold">
                              {immobile.codiceRiferimento || '-'}
                            </td>

                            <td className="px-4 py-3 text-gray-800 font-semibold">
                              {immobile.titolo}

                              {immobile.mostraInSlide && (
                                  <div className="text-xs text-green-700 mt-1 font-semibold">
                                    In slide Home
                                  </div>
                              )}
                            </td>

                            <td className="px-4 py-3 text-gray-600">
                              {immobile.citta}
                            </td>

                            <td className="px-4 py-3 font-semibold text-blue-600">
                              {Number(immobile.prezzo).toLocaleString('it-IT')} €
                            </td>

                            <td className="px-4 py-3">
                          <span
                              className={`${getStatoClassName(
                                  immobile.stato
                              )} px-2 py-1 rounded text-sm font-semibold`}
                          >
                            {getStatoLabel(immobile.stato)}
                          </span>
                            </td>

                            <td className="px-4 py-3">
                              <div className="flex justify-center gap-2">
                                <button
                                    type="button"
                                    onClick={() => handleEdit(immobile.id)}
                                    className="p-2 text-blue-600 hover:bg-blue-50 rounded"
                                    title="Modifica"
                                >
                                  <Edit className="w-4 h-4" />
                                </button>

                                <button
                                    type="button"
                                    onClick={() =>
                                        window.open(
                                            `/immobili/${immobile.id}`,
                                            '_blank',
                                            'noopener,noreferrer'
                                        )
                                    }
                                    className="p-2 text-green-600 hover:bg-green-50 rounded"
                                    title="Visualizza annuncio"
                                    aria-label={`Visualizza annuncio ${immobile.titolo}`}
                                >
                                  <Eye className="w-4 h-4" />
                                </button>

                                <button
                                    type="button"
                                    onClick={() => handleOpenNote(immobile)}
                                    className="p-2 text-yellow-600 hover:bg-yellow-50 rounded"
                                    title="Note private"
                                >
                                  <StickyNote className="w-4 h-4" />
                                </button>

                                <button
                                    type="button"
                                    onClick={() => handleDelete(immobile.id)}
                                    className="p-2 text-red-600 hover:bg-red-50 rounded"
                                    title="Elimina"
                                >
                                  <Trash2 className="w-4 h-4" />
                                </button>
                              </div>
                            </td>
                          </tr>
                      ))}
                      </tbody>
                    </table>
                  </div>
              )}
            </div>
          </div>

          {/* Note private */}
          {selectedNoteId && (
              <div
                  id="note-private-section"
                  className="bg-white rounded-lg shadow-lg mt-8 p-6 border border-yellow-200"
              >
                <div className="flex items-start justify-between gap-4 mb-4">
                  <div>
                    <h2 className="text-2xl font-bold text-gray-800">
                      Note private per l'immobile
                    </h2>

                    <p className="text-gray-600 mt-1">
                      {selectedNoteImmobile?.titolo} — Rif.{' '}
                      {selectedNoteImmobile?.codiceRiferimento ||
                          selectedNoteImmobile?.id}
                    </p>
                  </div>

                  <button
                      type="button"
                      onClick={handleCloseNote}
                      className="text-gray-500 hover:text-gray-800 font-semibold"
                  >
                    Chiudi
                  </button>
                </div>

                {noteLoading ? (
                    <p className="text-gray-600">Caricamento note...</p>
                ) : (
                    <>
                <textarea
                    value={noteText}
                    onChange={(e) => setNoteText(e.target.value)}
                    rows="8"
                    placeholder="Scrivi qui note interne, appuntamenti, informazioni del proprietario, promemoria o dettagli non visibili al pubblico..."
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-yellow-500 focus:outline-none"
                />

                      <div className="flex gap-4 mt-4">
                        <button
                            type="button"
                            onClick={handleSaveNote}
                            disabled={noteSaving}
                            className="bg-yellow-500 text-gray-900 px-6 py-3 rounded-lg hover:bg-yellow-600 font-semibold flex items-center gap-2 disabled:bg-gray-300"
                        >
                          <Save className="w-5 h-5" />
                          {noteSaving ? 'Salvataggio...' : 'Salva note'}
                        </button>

                        <button
                            type="button"
                            onClick={handleCloseNote}
                            className="bg-gray-200 text-gray-800 px-6 py-3 rounded-lg hover:bg-gray-300 font-semibold"
                        >
                          Annulla
                        </button>
                      </div>
                    </>
                )}
              </div>
          )}
        </div>
      </div>
  )
}