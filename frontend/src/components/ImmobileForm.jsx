import { useState } from 'react'

export default function ImmobileForm({ onSubmit, initialData, onCancel }) {
  const [formData, setFormData] = useState(
    initialData || {
      titolo: '',
      descrizione: '',
      prezzo: '',
      citta: '',
      provincia: '',
      via: '',
      numeroCivico: '',
      tipo: 'APPARTAMENTO',
      superficieMq: '',
      numeroLocali: '',
      numeroBagni: '',
      piano: '',
      ascensore: false,
      riscaldamento: '',
    }
  )

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target
    setFormData({
      ...formData,
      [name]: type === 'checkbox' ? checked : value,
    })
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    onSubmit({
      ...formData,
      prezzo: parseFloat(formData.prezzo),
      superficieMq: parseFloat(formData.superficieMq) || null,
      numeroLocali: parseInt(formData.numeroLocali) || null,
      numeroBagni: parseInt(formData.numeroBagni) || null,
      piano: parseInt(formData.piano) || null,
    })
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
            value={formData.titolo}
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
            value={formData.prezzo}
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
            value={formData.citta}
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
            value={formData.provincia}
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
            value={formData.via}
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
            value={formData.numeroCivico}
            onChange={handleChange}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
          />
        </div>

        {/* Tipo */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Tipo *
          </label>
          <select
            name="tipo"
            value={formData.tipo}
            onChange={handleChange}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
          >
            <option value="CASA">Casa</option>
            <option value="APPARTAMENTO">Appartamento</option>
            <option value="VILLA">Villa</option>
            <option value="TERRENO">Terreno</option>
            <option value="GARAGE">Garage</option>
            <option value="UFFICIO">Ufficio</option>
          </select>
        </div>

        {/* Superficie */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Superficie (m²)
          </label>
          <input
            type="number"
            name="superficieMq"
            value={formData.superficieMq}
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
            value={formData.numeroLocali}
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
            value={formData.numeroBagni}
            onChange={handleChange}
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
            value={formData.piano}
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
            value={formData.riscaldamento}
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
            checked={formData.ascensore}
            onChange={handleChange}
            className="w-4 h-4 text-blue-600 border-gray-300 rounded focus:ring-2 focus:ring-blue-500"
          />
          <label htmlFor="ascensore" className="ml-2 text-sm font-medium text-gray-700">
            Ascensore
          </label>
        </div>
      </div>

      {/* Descrizione */}
      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">
          Descrizione
        </label>
        <textarea
          name="descrizione"
          value={formData.descrizione}
          onChange={handleChange}
          rows="4"
          className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500"
        />
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

