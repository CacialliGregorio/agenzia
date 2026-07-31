import { useEffect, useState } from 'react'
import {
  UploadCloud,
  X,
  Image as ImageIcon,
  ArrowLeft,
  ArrowRight,
} from 'lucide-react'
import axiosInstance from '../api/axiosInstance'

const BACKEND_URL =
    import.meta.env.VITE_BACKEND_URL || 'http://localhost:8080'

const formVuoto = {
  titolo: '',
  descrizione: '',
  prezzo: '',
  citta: '',
  provincia: '',
  via: '',
  numeroCivico: '',
  codiceRiferimento: '',
  ubicazione: '',
  destinazione: '',
  tipo: [],
  stato: 'DISPONIBILE',
  superficieMq: '',
  numeroLocali: '',
  numeroBagni: '',
  camereDaLetto: '',
  piano: '',
  ascensore: false,
  garage: false,
  pannelliSolari: false,
  terrazza: false,
  riscaldamentoPavimento: false,
  giardino: false,
  piscina: false,
  impiantoAllarme: false,
  ariaCondizionata: false,
  vistaPanoramica: false,
  ripostiglio: false,
  termoautonomo: false,
  portaBlindata: false,
  cappotto: false,
  cortilePrivato: false,
  riscaldamento: '',
}

const opzioniUbicazione = [
  { value: 'CENTRALE', label: 'Centrale' },
  { value: 'FUORI_CITTA', label: 'Fuori Città' },
  { value: 'PERIFERIA', label: 'Periferia' },
  { value: 'SEMI_CENTRALE', label: 'Semi-Centrale' },
]

const opzioniDestinazione = [
  { value: 'AFFITTO', label: 'Affitto' },
  { value: 'AFFITTO_SEMI_ARREDATO', label: 'Affitto semi-arredato' },
  { value: 'VENDITA', label: 'Vendita' },
]

const opzioniTipo = [
  { value: 'VILLA', label: 'Villa' },
  { value: 'VILLETTA', label: 'Villetta' },
  { value: 'APPARTAMENTO', label: 'Appartamento' },
  { value: 'ATTICO', label: 'Attico' },
  { value: 'ATTIVITA_COMMERCIALE', label: 'Attività Commerciale' },
  { value: 'BILOCALE', label: 'Bilocale' },
  { value: 'BOX', label: 'Box' },
  { value: 'CASA_INDIPENDENTE', label: 'Casa Indipendente' },
  { value: 'CASCINA', label: 'Cascina' },
  { value: 'FABBRICATO', label: 'Fabbricato' },
  { value: 'LABORATORIO', label: 'Laboratorio' },
  { value: 'LOFT', label: 'Loft' },
  { value: 'MAGAZZINO_CAPANNONE', label: 'Magazzino/Capannone' },
  { value: 'MANSARDA', label: 'Mansarda' },
  { value: 'MONOLOCALE', label: 'Monolocale' },
  { value: 'NEGOZIO', label: 'Negozio' },
  { value: 'RUSTICO', label: 'Rustico' },
  { value: 'STUDIO', label: 'Studio' },
  { value: 'TERRENO', label: 'Terreno' },
]

const caratteristicheImmobile = [
  { name: 'pannelliSolari', label: 'Pannelli Solari' },
  { name: 'garage', label: 'Garage' },
  { name: 'terrazza', label: 'Terrazza' },
  { name: 'riscaldamentoPavimento', label: 'Riscaldamento a Pavimento' },
  { name: 'giardino', label: 'Giardino' },
  { name: 'piscina', label: 'Piscina' },
  { name: 'impiantoAllarme', label: 'Impianto Allarme' },
  { name: 'ariaCondizionata', label: 'Aria Condizionata' },
  { name: 'vistaPanoramica', label: 'Vista Panoramica' },
  { name: 'ripostiglio', label: 'Ripostiglio' },
  { name: 'termoautonomo', label: 'Termoautonomo' },
  { name: 'portaBlindata', label: 'Porta Blindata' },
  { name: 'cappotto', label: 'Cappotto' },
  { name: 'cortilePrivato', label: 'Cortile Privato' },
]

export default function ImmobileForm({ onSubmit, initialData, onCancel }) {
  const [formData, setFormData] = useState(formVuoto)
  const [fotoFiles, setFotoFiles] = useState([])
  const [fotoEsistenti, setFotoEsistenti] = useState(initialData?.fotoUrl || [])
  const [isDragging, setIsDragging] = useState(false)
  const [eliminazioneFoto, setEliminazioneFoto] = useState(false)
  const [salvataggioOrdine, setSalvataggioOrdine] = useState(false)

  useEffect(() => {
    if (initialData) {
      setFormData({
        ...initialData,
        tipo: initialData.tipo
            ? initialData.tipo.split(',').map((valore) => valore.trim())
            : [],
      })
    } else {
      setFormData(formVuoto)
    }

    setFotoEsistenti(initialData?.fotoUrl || [])
    setFotoFiles([])
  }, [initialData])

  const getFotoUrl = (foto) => {
    if (!foto) {
      return null
    }

    if (foto.startsWith('http')) {
      return foto
    }

    return `${BACKEND_URL}${foto}`
  }

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target

    setFormData({
      ...formData,
      [name]: type === 'checkbox' ? checked : value,
    })
  }

  const handleSceltaSingola = (name, value) => {
    setFormData({
      ...formData,
      [name]: value,
    })
  }

  const handleTipoMultiplo = (value) => {
    const tipiAttuali = Array.isArray(formData.tipo) ? formData.tipo : []

    const nuoviTipi = tipiAttuali.includes(value)
        ? tipiAttuali.filter((tipo) => tipo !== value)
        : [...tipiAttuali, value]

    setFormData({
      ...formData,
      tipo: nuoviTipi,
    })
  }

  const aggiungiFoto = (files) => {
    const immagini = Array.from(files).filter((file) =>
        file.type.startsWith('image/')
    )

    setFotoFiles((prev) => [...prev, ...immagini])
  }

  const handleFileChange = (e) => {
    aggiungiFoto(e.target.files)
    e.target.value = ''
  }

  const handleDrop = (e) => {
    e.preventDefault()
    setIsDragging(false)
    aggiungiFoto(e.dataTransfer.files)
  }

  const rimuoviFotoNuova = (indexDaRimuovere) => {
    setFotoFiles((prev) =>
        prev.filter((_, index) => index !== indexDaRimuovere)
    )
  }

  const eliminaFotoEsistente = async (fotoDaEliminare) => {
    if (!initialData?.id) {
      return
    }

    const conferma = window.confirm(
        'Vuoi eliminare definitivamente questa foto?'
    )

    if (!conferma) {
      return
    }

    setEliminazioneFoto(true)

    try {
      await axiosInstance.delete(`/immobili/${initialData.id}/foto`, {
        params: {
          percorso: fotoDaEliminare,
        },
      })

      setFotoEsistenti((prev) =>
          prev.filter((foto) => foto !== fotoDaEliminare)
      )
    } catch (error) {
      console.error('Errore eliminazione foto:', error)
      alert("Errore durante l'eliminazione della foto")
    } finally {
      setEliminazioneFoto(false)
    }
  }

  const salvaOrdineFoto = async (nuovoOrdine) => {
    if (!initialData?.id) {
      return
    }

    setSalvataggioOrdine(true)

    try {
      await axiosInstance.put(`/immobili/${initialData.id}/foto/ordine`, {
        fotoUrl: nuovoOrdine,
      })
    } catch (error) {
      console.error('Errore aggiornamento ordine foto:', error)
      alert("Errore durante l'aggiornamento dell'ordine delle foto")
    } finally {
      setSalvataggioOrdine(false)
    }
  }

  const spostaFotoEsistente = async (index, direzione) => {
    const nuovoIndice = index + direzione

    if (nuovoIndice < 0 || nuovoIndice >= fotoEsistenti.length) {
      return
    }

    const nuovoOrdine = [...fotoEsistenti]

    const fotoTemporanea = nuovoOrdine[index]
    nuovoOrdine[index] = nuovoOrdine[nuovoIndice]
    nuovoOrdine[nuovoIndice] = fotoTemporanea

    setFotoEsistenti(nuovoOrdine)

    await salvaOrdineFoto(nuovoOrdine)
  }

  const handleSubmit = (e) => {
    e.preventDefault()

    const datiImmobile = {
      ...formData,
      tipo: Array.isArray(formData.tipo)
          ? formData.tipo.join(',')
          : formData.tipo,
      stato: formData.stato || 'DISPONIBILE',
      prezzo: parseFloat(formData.prezzo),
      superficieMq: parseFloat(formData.superficieMq) || null,
      numeroLocali: parseInt(formData.numeroLocali) || null,
      numeroBagni: parseInt(formData.numeroBagni) || null,
      camereDaLetto: parseInt(formData.camereDaLetto) || null,
      piano:
          formData.piano === '' || formData.piano === null
              ? null
              : parseInt(formData.piano),
    }

    if (!datiImmobile.tipo) {
      alert('Seleziona almeno un tipo di immobile')
      return
    }

    onSubmit(datiImmobile, fotoFiles)
  }

  return (
      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {/* Titolo */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Titolo *
            </label>
            <input
                type="text"
                name="titolo"
                value={formData.titolo || ''}
                onChange={handleChange}
                required
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Prezzo */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Prezzo (€) *
            </label>
            <input
                type="number"
                name="prezzo"
                value={formData.prezzo || ''}
                onChange={handleChange}
                required
                step="0.01"
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Città */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Città *
            </label>
            <input
                type="text"
                name="citta"
                value={formData.citta || ''}
                onChange={handleChange}
                required
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Provincia */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Provincia
            </label>
            <input
                type="text"
                name="provincia"
                value={formData.provincia || ''}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Via */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Via
            </label>
            <input
                type="text"
                name="via"
                value={formData.via || ''}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Numero Civico */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Numero Civico
            </label>
            <input
                type="text"
                name="numeroCivico"
                value={formData.numeroCivico || ''}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Codice riferimento */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Codice riferimento immobile
            </label>
            <input
                type="text"
                name="codiceRiferimento"
                value={formData.codiceRiferimento || ''}
                onChange={handleChange}
                placeholder="Es: 1813"
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
            <p className="text-xs text-gray-500 mt-1">
              Questo codice sarà usato dai clienti per cercare l'annuncio.
            </p>
          </div>

          {/* Ubicazione */}
          <div className="md:col-span-2 border border-gray-200 rounded-xl bg-white shadow-sm">
            <div className="px-4 py-3 border-b border-gray-200">
              <h3 className="text-lg font-bold text-gray-800">Ubicazione</h3>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-4 gap-4 p-4">
              {opzioniUbicazione.map((opzione) => (
                  <button
                      key={opzione.value}
                      type="button"
                      onClick={() => handleSceltaSingola('ubicazione', opzione.value)}
                      className={`p-3 border rounded-lg font-semibold text-left transition ${
                          formData.ubicazione === opzione.value
                              ? 'bg-blue-50 border-blue-600 text-blue-700'
                              : 'bg-white border-gray-200 text-gray-700 hover:bg-gray-50'
                      }`}
                  >
                    {opzione.label}
                  </button>
              ))}
            </div>
          </div>

          {/* Destinazione */}
          <div className="md:col-span-2 border border-gray-200 rounded-xl bg-white shadow-sm">
            <div className="px-4 py-3 border-b border-gray-200">
              <h3 className="text-lg font-bold text-gray-800">Destinazione</h3>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 p-4">
              {opzioniDestinazione.map((opzione) => (
                  <button
                      key={opzione.value}
                      type="button"
                      onClick={() =>
                          handleSceltaSingola('destinazione', opzione.value)
                      }
                      className={`p-3 border rounded-lg font-semibold text-left transition ${
                          formData.destinazione === opzione.value
                              ? 'bg-blue-50 border-blue-600 text-blue-700'
                              : 'bg-white border-gray-200 text-gray-700 hover:bg-gray-50'
                      }`}
                  >
                    {opzione.label}
                  </button>
              ))}
            </div>
          </div>

          {/* Tipo */}
          <div className="md:col-span-2 border border-gray-200 rounded-xl bg-white shadow-sm">
            <div className="px-4 py-3 border-b border-gray-200">
              <h3 className="text-lg font-bold text-gray-800">Tipo *</h3>
              <p className="text-sm text-gray-500 mt-1">
                Puoi selezionare uno o più tipi per lo stesso immobile.
              </p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-4 gap-4 p-4">
              {opzioniTipo.map((opzione) => {
                const selezionato = Array.isArray(formData.tipo)
                    ? formData.tipo.includes(opzione.value)
                    : formData.tipo === opzione.value

                return (
                    <button
                        key={opzione.value}
                        type="button"
                        onClick={() => handleTipoMultiplo(opzione.value)}
                        className={`p-3 border rounded-lg font-semibold text-left transition ${
                            selezionato
                                ? 'bg-blue-50 border-blue-600 text-blue-700'
                                : 'bg-white border-gray-200 text-gray-700 hover:bg-gray-50'
                        }`}
                    >
                  <span className="inline-flex items-center gap-2">
                    <span
                        className={`w-4 h-4 border rounded flex items-center justify-center text-xs ${
                            selezionato
                                ? 'bg-blue-600 border-blue-600 text-white'
                                : 'border-gray-300'
                        }`}
                    >
                      {selezionato ? '✓' : ''}
                    </span>

                    {opzione.label}
                  </span>
                    </button>
                )
              })}
            </div>
          </div>

          {/* Stato */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Stato annuncio *
            </label>
            <select
                name="stato"
                value={formData.stato || 'DISPONIBILE'}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            >
              <option value="DISPONIBILE">Disponibile</option>
              <option value="VENDUTO">Venduto</option>
              <option value="AFFITTATO">Affittato</option>
            </select>
            <p className="text-xs text-gray-500 mt-1">
              Solo gli immobili disponibili vengono mostrati nel sito pubblico.
            </p>
          </div>

          {/* Superficie */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Superficie (m²)
            </label>
            <input
                type="number"
                name="superficieMq"
                value={formData.superficieMq || ''}
                onChange={handleChange}
                step="0.01"
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Locali */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Numero Locali
            </label>
            <input
                type="number"
                name="numeroLocali"
                value={formData.numeroLocali || ''}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Bagni */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Numero Bagni
            </label>
            <input
                type="number"
                name="numeroBagni"
                value={formData.numeroBagni || ''}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Camere da letto */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Camere da letto
            </label>
            <input
                type="number"
                name="camereDaLetto"
                value={formData.camereDaLetto || ''}
                onChange={handleChange}
                min="0"
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Piano */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Piano
            </label>
            <input
                type="number"
                name="piano"
                value={formData.piano || ''}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Riscaldamento */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Riscaldamento
            </label>
            <input
                type="text"
                name="riscaldamento"
                value={formData.riscaldamento || ''}
                onChange={handleChange}
                placeholder="Es: Autonomo, Centralizzato"
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
            />
          </div>

          {/* Ascensore */}
          <div className="flex items-center">
            <input
                type="checkbox"
                name="ascensore"
                id="ascensore"
                checked={formData.ascensore || false}
                onChange={handleChange}
                className="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-2 focus:ring-blue-500"
            />

            <label
                htmlFor="ascensore"
                className="ml-2 text-sm font-medium text-gray-700"
            >
              Ascensore
            </label>
          </div>
        </div>

        {/* Caratteristiche */}
        <div className="border border-gray-200 rounded-xl bg-white shadow-sm">
          <div className="px-4 py-3 border-b border-gray-200">
            <h3 className="text-lg font-bold text-gray-800">Caratteristiche</h3>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 p-4">
            {caratteristicheImmobile.map((caratteristica) => (
                <label
                    key={caratteristica.name}
                    htmlFor={caratteristica.name}
                    className="flex items-center justify-between gap-3 p-3 border border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50"
                >
              <span className="text-sm font-semibold text-gray-700">
                {caratteristica.label}
              </span>

                  <input
                      type="checkbox"
                      name={caratteristica.name}
                      id={caratteristica.name}
                      checked={Boolean(formData[caratteristica.name])}
                      onChange={handleChange}
                      className="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-2 focus:ring-blue-500"
                  />
                </label>
            ))}
          </div>
        </div>

        {/* Descrizione */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Descrizione
          </label>

          <textarea
              name="descrizione"
              value={formData.descrizione || ''}
              onChange={handleChange}
              rows="4"
              className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
          />
        </div>

        {/* Foto già salvate */}
        {fotoEsistenti.length > 0 && (
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Foto già caricate
              </label>

              <p className="text-sm text-gray-500 mb-3">
                La prima foto mostrata sarà usata come immagine di copertina. Usa le
                frecce per cambiare ordine.
              </p>

              {eliminazioneFoto && (
                  <p className="text-sm text-blue-600 mb-3">
                    Eliminazione foto in corso...
                  </p>
              )}

              {salvataggioOrdine && (
                  <p className="text-sm text-blue-600 mb-3">
                    Salvataggio ordine foto in corso...
                  </p>
              )}

              <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                {fotoEsistenti.map((foto, index) => (
                    <div
                        key={`${foto}-${index}`}
                        className="relative border rounded-lg overflow-hidden bg-white"
                    >
                      {index === 0 && (
                          <div className="absolute top-2 left-2 bg-green-600 text-white text-xs px-2 py-1 rounded z-10">
                            Copertina
                          </div>
                      )}

                      <img
                          src={getFotoUrl(foto)}
                          alt={`Foto salvata ${index + 1}`}
                          className="w-full h-28 object-cover"
                      />

                      <button
                          type="button"
                          disabled={eliminazioneFoto || salvataggioOrdine}
                          onClick={() => eliminaFotoEsistente(foto)}
                          className="absolute top-2 right-2 bg-red-600 text-white rounded-full p-1 hover:bg-red-700 disabled:bg-gray-400"
                      >
                        <X className="w-4 h-4" />
                      </button>

                      <div className="px-2 py-2 text-xs text-gray-600">
                        <div className="mb-2">Foto {index + 1}</div>

                        <div className="flex items-center justify-between gap-2">
                          <button
                              type="button"
                              disabled={
                                  index === 0 || eliminazioneFoto || salvataggioOrdine
                              }
                              onClick={() => spostaFotoEsistente(index, -1)}
                              className="flex-1 flex items-center justify-center bg-gray-100 hover:bg-gray-200 disabled:opacity-40 disabled:cursor-not-allowed px-2 py-1 rounded"
                              title="Sposta a sinistra"
                          >
                            <ArrowLeft className="w-4 h-4" />
                          </button>

                          <button
                              type="button"
                              disabled={
                                  index === fotoEsistenti.length - 1 ||
                                  eliminazioneFoto ||
                                  salvataggioOrdine
                              }
                              onClick={() => spostaFotoEsistente(index, 1)}
                              className="flex-1 flex items-center justify-center bg-gray-100 hover:bg-gray-200 disabled:opacity-40 disabled:cursor-not-allowed px-2 py-1 rounded"
                              title="Sposta a destra"
                          >
                            <ArrowRight className="w-4 h-4" />
                          </button>
                        </div>
                      </div>
                    </div>
                ))}
              </div>
            </div>
        )}

        {/* Upload nuove immagini */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-2">
            Aggiungi nuove foto
          </label>

          <div
              onDragOver={(e) => {
                e.preventDefault()
                setIsDragging(true)
              }}
              onDragLeave={() => setIsDragging(false)}
              onDrop={handleDrop}
              className={`border-2 border-dashed rounded-xl p-6 text-center transition ${
                  isDragging ? 'border-blue-500 bg-blue-50' : 'border-gray-300 bg-gray-50'
              }`}
          >
            <UploadCloud className="w-10 h-10 mx-auto text-gray-500 mb-3" />

            <p className="text-gray-700 font-medium">
              Trascina qui le foto dell’immobile
            </p>

            <p className="text-sm text-gray-500 mb-4">
              oppure selezionale dal computer
            </p>

            <label className="inline-block bg-blue-600 text-white px-5 py-2 rounded-lg hover:bg-blue-700 cursor-pointer font-semibold">
              Scegli foto
              <input
                  type="file"
                  accept="image/*"
                  multiple
                  onChange={handleFileChange}
                  className="hidden"
              />
            </label>
          </div>

          {fotoFiles.length > 0 && (
              <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mt-4">
                {fotoFiles.map((file, index) => (
                    <div
                        key={`${file.name}-${index}`}
                        className="relative border rounded-lg overflow-hidden bg-white"
                    >
                      <img
                          src={URL.createObjectURL(file)}
                          alt={`Anteprima ${index + 1}`}
                          className="w-full h-28 object-cover"
                      />

                      <button
                          type="button"
                          onClick={() => rimuoviFotoNuova(index)}
                          className="absolute top-2 right-2 bg-red-600 text-white rounded-full p-1 hover:bg-red-700"
                      >
                        <X className="w-4 h-4" />
                      </button>

                      <div className="flex items-center gap-1 px-2 py-1 text-xs text-gray-600 truncate">
                        <ImageIcon className="w-3 h-3" />
                        <span className="truncate">{file.name}</span>
                      </div>
                    </div>
                ))}
              </div>
          )}
        </div>

        {/* Buttons */}
        <div className="flex gap-4 pt-4">
          <button
              type="submit"
              className="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 font-semibold"
          >
            Salva
          </button>

          <button
              type="button"
              onClick={onCancel}
              className="bg-gray-300 text-gray-800 px-6 py-2 rounded-lg hover:bg-gray-400 font-semibold"
          >
            Annulla
          </button>
        </div>
      </form>
  )
}