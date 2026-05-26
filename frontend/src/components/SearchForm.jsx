import { useState } from 'react'
import { ChevronDown } from 'lucide-react'

export default function SearchForm({ onSearch }) {
  const [formData, setFormData] = useState({
    localita: '',
    ubicazione: '',
    destinazione: '',
    tipo: '',
    camereLettoMin: '',
    camereLettoMax: '',
    bagniMin: '',
    bagniMax: '',
    prezzoMin: 0,
    prezzoMax: 2000000,
    id: '',
  })

  const [openDropdown, setOpenDropdown] = useState(null)
  const [filterText, setFilterText] = useState({
    localita: '',
    ubicazione: '',
    destinazione: '',
    tipo: '',
    camereLettoMin: '',
    camereLettoMax: '',
    bagniMin: '',
    bagniMax: '',
  })

  const options = {
    localita: [
      'Bagnara',
      'Bonemerse',
      'Casalbuttano',
      'Castelverde',
      'Castelvetro Piacentino',
      'Cremona',
      'Gadesco Pieve Delmona',
      "Pieve d'Olmi",
      'Seniga (Bs)',
    ],
    ubicazione: [
      'Centrale',
      'Fuori Città',
      'Periferia',
      'Semi-Centrale',
    ],
    destinazione: [
      'Affitto',
      'Affitto Semi Arredato',
      'Vendita',
    ],
    tipo: [
      'Attico',
      'Bilocale',
      'Box',
      'Casa Indipendente',
      'Cascina',
      'Fabbricato',
      'Laboratorio',
      'Magazzino/Capannone',
    ],
    camere: ['1', '2', '3', '4', '5', '6', '7', '8'],
    bagni: ['1', '2', '3', '4', '5', '6', '7', '8'],
  }

  const getFilteredOptions = (key) => {
    const filter = filterText[key]?.toLowerCase() || ''
    return options[key].filter((option) =>
        option.toLowerCase().includes(filter)
    )
  }

  const handleDropdownChange = (key, value) => {
    setFormData({ ...formData, [key]: value })
    setOpenDropdown(null)
    setFilterText({ ...filterText, [key]: '' })
  }

  const handlePriceChange = (side, value) => {
    const numValue = parseInt(value)

    if (side === 'min') {
      if (numValue <= formData.prezzoMax) {
        setFormData({ ...formData, prezzoMin: numValue })
      }
    } else {
      if (numValue >= formData.prezzoMin) {
        setFormData({ ...formData, prezzoMax: numValue })
      }
    }
  }

  const handleSearch = () => {
    if (onSearch) {
      onSearch(formData)
    }
  }

  return (
      <div className="bg-gradient-to-r from-green-400 to-green-600 py-12 px-4">
        <div className="max-w-7xl mx-auto">
          {/* Titolo */}
          <div className="text-center mb-8">
            <h1 className="text-4xl font-bold text-white mb-2">TROVA IMMOBILI</h1>
            <p className="text-white text-lg">
              Trova subito l'immobile adatto a te nella zona che vuoi. Comincia subito una ricerca!
            </p>
          </div>

          {/* Form */}
          <div className="bg-white rounded-lg shadow-xl p-8">
            {/* Prima riga */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
              {/* LOCALITA */}
              <div className="relative">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Località
                </label>

                <button
                    type="button"
                    onClick={() =>
                        setOpenDropdown(openDropdown === 'localita' ? null : 'localita')
                    }
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg bg-white flex justify-between items-center hover:border-gray-400 focus:outline-none focus:ring-2 focus:ring-green-500"
                >
                  <span>{formData.localita || 'Seleziona'}</span>
                  <ChevronDown className="w-4 h-4" />
                </button>

                {openDropdown === 'localita' && (
                    <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-300 rounded-lg shadow-lg z-10 max-h-60 overflow-hidden">
                      <input
                          type="text"
                          placeholder="Filtra..."
                          value={filterText.localita}
                          onChange={(e) =>
                              setFilterText({ ...filterText, localita: e.target.value })
                          }
                          className="w-full px-4 py-2 border-b border-gray-300 focus:outline-none"
                      />

                      <div className="overflow-y-auto max-h-48">
                        {getFilteredOptions('localita').map((option) => (
                            <button
                                type="button"
                                key={option}
                                onClick={() => handleDropdownChange('localita', option)}
                                className="w-full text-left px-4 py-2 hover:bg-green-50 transition"
                            >
                              {option}
                            </button>
                        ))}
                      </div>
                    </div>
                )}
              </div>

              {/* UBICAZIONE */}
              <div className="relative">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Ubicazione
                </label>

                <button
                    type="button"
                    onClick={() =>
                        setOpenDropdown(openDropdown === 'ubicazione' ? null : 'ubicazione')
                    }
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg bg-white flex justify-between items-center hover:border-gray-400 focus:outline-none focus:ring-2 focus:ring-green-500"
                >
                  <span>{formData.ubicazione || 'Seleziona'}</span>
                  <ChevronDown className="w-4 h-4" />
                </button>

                {openDropdown === 'ubicazione' && (
                    <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-300 rounded-lg shadow-lg z-10">
                      <input
                          type="text"
                          placeholder="Filtra..."
                          value={filterText.ubicazione}
                          onChange={(e) =>
                              setFilterText({ ...filterText, ubicazione: e.target.value })
                          }
                          className="w-full px-4 py-2 border-b border-gray-300 focus:outline-none"
                      />

                      <div className="max-h-48 overflow-y-auto">
                        {getFilteredOptions('ubicazione').map((option) => (
                            <button
                                type="button"
                                key={option}
                                onClick={() => handleDropdownChange('ubicazione', option)}
                                className="w-full text-left px-4 py-2 hover:bg-green-50 transition"
                            >
                              {option}
                            </button>
                        ))}
                      </div>
                    </div>
                )}
              </div>

              {/* DESTINAZIONE */}
              <div className="relative">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Destinazione
                </label>

                <button
                    type="button"
                    onClick={() =>
                        setOpenDropdown(openDropdown === 'destinazione' ? null : 'destinazione')
                    }
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg bg-white flex justify-between items-center hover:border-gray-400 focus:outline-none focus:ring-2 focus:ring-green-500"
                >
                  <span>{formData.destinazione || 'Seleziona'}</span>
                  <ChevronDown className="w-4 h-4" />
                </button>

                {openDropdown === 'destinazione' && (
                    <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-300 rounded-lg shadow-lg z-10">
                      <input
                          type="text"
                          placeholder="Filtra..."
                          value={filterText.destinazione}
                          onChange={(e) =>
                              setFilterText({
                                ...filterText,
                                destinazione: e.target.value,
                              })
                          }
                          className="w-full px-4 py-2 border-b border-gray-300 focus:outline-none"
                      />

                      <div className="max-h-48 overflow-y-auto">
                        {getFilteredOptions('destinazione').map((option) => (
                            <button
                                type="button"
                                key={option}
                                onClick={() => handleDropdownChange('destinazione', option)}
                                className="w-full text-left px-4 py-2 hover:bg-green-50 transition"
                            >
                              {option}
                            </button>
                        ))}
                      </div>
                    </div>
                )}
              </div>

              {/* TIPO */}
              <div className="relative">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Tipo
                </label>

                <button
                    type="button"
                    onClick={() =>
                        setOpenDropdown(openDropdown === 'tipo' ? null : 'tipo')
                    }
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg bg-white flex justify-between items-center hover:border-gray-400 focus:outline-none focus:ring-2 focus:ring-green-500"
                >
                  <span>{formData.tipo || 'Seleziona'}</span>
                  <ChevronDown className="w-4 h-4" />
                </button>

                {openDropdown === 'tipo' && (
                    <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-300 rounded-lg shadow-lg z-10">
                      <input
                          type="text"
                          placeholder="Filtra..."
                          value={filterText.tipo}
                          onChange={(e) =>
                              setFilterText({ ...filterText, tipo: e.target.value })
                          }
                          className="w-full px-4 py-2 border-b border-gray-300 focus:outline-none"
                      />

                      <div className="max-h-48 overflow-y-auto">
                        {getFilteredOptions('tipo').map((option) => (
                            <button
                                type="button"
                                key={option}
                                onClick={() => handleDropdownChange('tipo', option)}
                                className="w-full text-left px-4 py-2 hover:bg-green-50 transition"
                            >
                              {option}
                            </button>
                        ))}
                      </div>
                    </div>
                )}
              </div>
            </div>

            {/* Seconda riga */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
              {/* CAMERE DA LETTO */}
              <div className="relative">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Camere da Letto
                </label>

                <button
                    type="button"
                    onClick={() =>
                        setOpenDropdown(
                            openDropdown === 'camereLettoMin' ? null : 'camereLettoMin'
                        )
                    }
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg bg-white flex justify-between items-center hover:border-gray-400 focus:outline-none focus:ring-2 focus:ring-green-500"
                >
                  <span>{formData.camereLettoMin || 'Seleziona'}</span>
                  <ChevronDown className="w-4 h-4" />
                </button>

                {openDropdown === 'camereLettoMin' && (
                    <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-300 rounded-lg shadow-lg z-10">
                      <div className="max-h-48 overflow-y-auto">
                        {options.camere.map((option) => (
                            <button
                                type="button"
                                key={option}
                                onClick={() =>
                                    handleDropdownChange('camereLettoMin', option)
                                }
                                className="w-full text-left px-4 py-2 hover:bg-green-50 transition"
                            >
                              {option}
                            </button>
                        ))}
                      </div>
                    </div>
                )}
              </div>

              {/* BAGNI */}
              <div className="relative">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Bagni
                </label>

                <button
                    type="button"
                    onClick={() =>
                        setOpenDropdown(openDropdown === 'bagniMin' ? null : 'bagniMin')
                    }
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg bg-white flex justify-between items-center hover:border-gray-400 focus:outline-none focus:ring-2 focus:ring-green-500"
                >
                  <span>{formData.bagniMin || 'Seleziona'}</span>
                  <ChevronDown className="w-4 h-4" />
                </button>

                {openDropdown === 'bagniMin' && (
                    <div className="absolute top-full left-0 right-0 mt-1 bg-white border border-gray-300 rounded-lg shadow-lg z-10">
                      <div className="max-h-48 overflow-y-auto">
                        {options.bagni.map((option) => (
                            <button
                                type="button"
                                key={option}
                                onClick={() => handleDropdownChange('bagniMin', option)}
                                className="w-full text-left px-4 py-2 hover:bg-green-50 transition"
                            >
                              {option}
                            </button>
                        ))}
                      </div>
                    </div>
                )}
              </div>

              {/* PREZZO */}
              <div className="col-span-1 md:col-span-2 lg:col-span-1">
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Prezzo
                </label>

                <div className="space-y-3">
                  <div className="flex items-center gap-2">
                    <span className="text-xs text-gray-600">Min:</span>

                    <input
                        type="range"
                        min="0"
                        max="2000000"
                        step="10000"
                        value={formData.prezzoMin}
                        onChange={(e) => handlePriceChange('min', e.target.value)}
                        className="flex-1 h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-green-500"
                    />

                    <span className="text-xs font-medium text-green-600 whitespace-nowrap">
                    {(formData.prezzoMin / 1000).toFixed(0)}k€
                  </span>
                  </div>

                  <div className="flex items-center gap-2">
                    <span className="text-xs text-gray-600">Max:</span>

                    <input
                        type="range"
                        min="0"
                        max="2000000"
                        step="10000"
                        value={formData.prezzoMax}
                        onChange={(e) => handlePriceChange('max', e.target.value)}
                        className="flex-1 h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-green-500"
                    />

                    <span className="text-xs font-medium text-green-600 whitespace-nowrap">
                    {(formData.prezzoMax / 1000).toFixed(0)}k€
                  </span>
                  </div>

                  <div className="text-center text-xs text-gray-600 pt-1 border-t">
                    {formData.prezzoMin.toLocaleString('it-IT')}€ -{' '}
                    {formData.prezzoMax.toLocaleString('it-IT')}€
                  </div>
                </div>
              </div>

              {/* ID */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  ID
                </label>

                <div className="w-full px-4 py-3 border border-gray-300 rounded-lg bg-gray-100 text-gray-600 text-sm">
                  Auto-generato
                </div>
              </div>
            </div>

            {/* Bottone CERCA */}
            <button
                type="button"
                onClick={handleSearch}
                className="w-full bg-yellow-400 hover:bg-yellow-500 text-gray-800 font-bold text-xl py-4 rounded-lg transition transform hover:scale-105 mt-6"
            >
              CERCA
            </button>
          </div>
        </div>
      </div>
  )
}