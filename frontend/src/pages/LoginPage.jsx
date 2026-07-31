import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import axiosInstance from '../api/axiosInstance'

export default function LoginPage() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [mostraPassword, setMostraPassword] = useState(false)
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)

  const navigate = useNavigate()

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setLoading(true)

    try {
      const response = await axiosInstance.post('/auth/login', {
        email,
        password,
      })

      const { token, userId, nome, cognome } = response.data

      localStorage.setItem('token', token)
      localStorage.setItem('userId', userId)
      localStorage.setItem(
          'userInfo',
          JSON.stringify({ nome, cognome, email })
      )

      navigate('/dashboard')
    } catch (err) {
      setError('Email o password non validi')
      console.error('Login error:', err)
    } finally {
      setLoading(false)
    }
  }

  return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex flex-col">
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

            <div>
              <button
                  type="button"
                  onClick={() => navigate('/')}
                  className="hover:text-gray-300 flex items-center gap-1"
              >
                ← Torna alla Home
              </button>
            </div>
          </div>
        </div>

        {/* Login Form Container */}
        <div className="flex-1 flex items-center justify-center p-4">
          <div className="bg-white rounded-lg shadow-xl p-8 max-w-md w-full">
            <div className="flex justify-center mb-6">
              <img src="/logo.jpeg" alt="Agenzia Logo" className="h-16 w-auto" />
            </div>

            <h1 className="text-3xl font-bold text-center text-gray-800 mb-2">
              Area Dipendenti
            </h1>

            <p className="text-center text-gray-600 mb-6">
              Accedi per gestire gli annunci
            </p>

            <form onSubmit={handleSubmit} className="space-y-4">
              {error && (
                  <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded">
                    {error}
                  </div>
              )}

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Email
                </label>

                <input
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="Inserisci la tua email"
                    required
                    className={`w-full px-4 py-2 border rounded-lg focus:ring-2 focus:border-transparent transition-all ${
                        error
                            ? 'border-red-500 focus:ring-red-500 bg-red-50'
                            : 'border-gray-300 focus:ring-blue-500'
                    }`}
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Password
                </label>

                <div className="relative">
                  <input
                      type={mostraPassword ? 'text' : 'password'}
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      placeholder="Inserisci la tua password"
                      required
                      className={`w-full px-4 py-2 pr-24 border rounded-lg focus:ring-2 focus:border-transparent transition-all ${
                          error
                              ? 'border-red-500 focus:ring-red-500 bg-red-50'
                              : 'border-gray-300 focus:ring-blue-500'
                      }`}
                  />

                  <button
                      type="button"
                      onClick={() => setMostraPassword(!mostraPassword)}
                      className="absolute inset-y-0 right-3 flex items-center text-sm font-medium text-gray-500 hover:text-gray-800"
                  >
                    {mostraPassword ? 'Nascondi' : 'Mostra'}
                  </button>
                </div>
              </div>

              <button
                  type="submit"
                  disabled={loading}
                  className="w-full bg-blue-600 text-white py-2 rounded-lg font-semibold hover:bg-blue-700 disabled:bg-gray-400 transition-colors"
              >
                {loading ? 'Accesso in corso...' : 'Accedi'}
              </button>
            </form>

            <p className="text-sm text-gray-500 text-center mt-4">
              Hai dimenticato la password? Contatta l’amministratore del sito.
            </p>
          </div>
        </div>
      </div>
  )
}