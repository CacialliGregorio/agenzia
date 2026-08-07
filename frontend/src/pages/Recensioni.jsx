import { useEffect, useState } from 'react'
import {
    Star,
} from 'lucide-react'
import axiosInstance from '../api/axiosInstance'
import PublicLayout from '../components/PublicLayout'

export default function Recensioni() {
    const [recensioni, setRecensioni] = useState([])
    const [voto, setVoto] = useState(5)
    const [testo, setTesto] = useState('')
    const [page, setPage] = useState(0)
    const [hasMore, setHasMore] = useState(false)
    const [loading, setLoading] = useState(false)
    const [saving, setSaving] = useState(false)
    const [errore, setErrore] = useState('')
    const [messaggio, setMessaggio] = useState('')

    useEffect(() => {
        fetchRecensioni(0, true)
    }, [])

    const fetchRecensioni = async (paginaDaCaricare = 0, reset = false) => {
        setLoading(true)
        setErrore('')

        try {
            const response = await axiosInstance.get('/recensioni', {
                params: {
                    page: paginaDaCaricare,
                    size: 5,
                },
            })

            const nuoveRecensioni = response.data.content || []

            if (reset) {
                setRecensioni(nuoveRecensioni)
            } else {
                setRecensioni((prev) => [...prev, ...nuoveRecensioni])
            }

            setPage(paginaDaCaricare)
            setHasMore(!response.data.last)
        } catch (error) {
            console.error('Errore caricamento recensioni:', error)
            setErrore('Errore nel caricamento delle recensioni.')
        } finally {
            setLoading(false)
        }
    }

    const handleSubmit = async (e) => {
        e.preventDefault()

        setErrore('')
        setMessaggio('')

        const testoPulito = testo.trim()

        if (!testoPulito) {
            setErrore('Scrivi il testo della recensione.')
            return
        }

        if (testoPulito.length > 500) {
            setErrore('La recensione non può superare i 500 caratteri.')
            return
        }

        setSaving(true)

        try {
            await axiosInstance.post('/recensioni', {
                voto,
                testo: testoPulito,
            })

            setTesto('')
            setVoto(5)
            setMessaggio('Recensione inviata correttamente.')

            await fetchRecensioni(0, true)
        } catch (error) {
            console.error('Errore invio recensione:', error)
            setErrore('Errore durante l’invio della recensione.')
        } finally {
            setSaving(false)
        }
    }

    const renderStars = (numeroStelle, cliccabili = false) => {
        return (
            <div className="flex gap-1">
                {[1, 2, 3, 4, 5].map((star) => (
                    <button
                        key={star}
                        type="button"
                        onClick={() => cliccabili && setVoto(star)}
                        disabled={!cliccabili}
                        className={cliccabili ? 'cursor-pointer' : 'cursor-default'}
                        aria-label={`${star} stelle`}
                    >
                        <Star
                            className={`w-6 h-6 ${
                                star <= numeroStelle
                                    ? 'fill-yellow-400 text-yellow-400'
                                    : 'text-gray-300'
                            }`}
                        />
                    </button>
                ))}
            </div>
        )
    }

    const formatData = (data) => {
        if (!data) {
            return ''
        }

        return new Date(data).toLocaleDateString('it-IT', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric',
        })
    }

    return (
        <PublicLayout activePage="recensioni">
            {/* Hero */}
            <section className="bg-gray-900 text-white py-14 md:py-20">
                <div className="max-w-7xl mx-auto px-4 text-center">
                    <h1 className="text-4xl md:text-5xl font-bold mb-4">
                        Recensioni
                    </h1>

                    <p className="text-base md:text-lg text-gray-300 max-w-2xl mx-auto">
                        Lascia una recensione anonima sulla tua esperienza con Il Mondo
                        Immobiliare.
                    </p>
                </div>
            </section>

            {/* Contenuto */}
            <main className="max-w-7xl mx-auto px-4 py-10 md:py-16">
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 md:gap-10">
                    {/* Form recensione */}
                    <section className="bg-white rounded-xl shadow-lg p-6 md:p-8">
                        <h2 className="text-2xl font-bold text-gray-800 mb-2">
                            Lascia una recensione
                        </h2>

                        <p className="text-gray-600 mb-6">
                            La recensione sarà pubblicata in forma anonima.
                        </p>

                        {errore && (
                            <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-4">
                                {errore}
                            </div>
                        )}

                        {messaggio && (
                            <div className="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg mb-4">
                                {messaggio}
                            </div>
                        )}

                        <form onSubmit={handleSubmit} className="space-y-5">
                            <div>
                                <label className="block text-sm font-semibold text-gray-700 mb-2">
                                    Voto
                                </label>

                                {renderStars(voto, true)}
                            </div>

                            <div>
                                <label className="block text-sm font-semibold text-gray-700 mb-2">
                                    Recensione
                                </label>

                                <textarea
                                    value={testo}
                                    onChange={(e) => setTesto(e.target.value)}
                                    rows="7"
                                    maxLength="500"
                                    placeholder="Scrivi qui la tua recensione..."
                                    className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:outline-none resize-none"
                                />

                                <p className="text-xs text-gray-500 mt-1">
                                    {testo.length}/500 caratteri
                                </p>
                            </div>

                            <button
                                type="submit"
                                disabled={saving}
                                className="w-full bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 disabled:bg-gray-300 transition"
                            >
                                {saving ? 'Invio in corso...' : 'Invia recensione'}
                            </button>
                        </form>
                    </section>

                    {/* Lista recensioni */}
                    <section>
                        <div className="mb-6">
                            <h2 className="text-2xl font-bold text-gray-800">
                                Recensioni ricevute
                            </h2>

                            <p className="text-gray-600 mt-1">
                                Mostrate dalla valutazione più alta alla più bassa.
                            </p>
                        </div>

                        {recensioni.length === 0 && !loading ? (
                            <div className="bg-white rounded-xl shadow p-6 text-gray-600">
                                Non ci sono ancora recensioni.
                            </div>
                        ) : (
                            <div className="space-y-4">
                                {recensioni.map((recensione) => (
                                    <article
                                        key={recensione.id}
                                        className="bg-white rounded-xl shadow p-5 md:p-6"
                                    >
                                        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 mb-3">
                                            {renderStars(recensione.voto)}

                                            <span className="text-sm text-gray-400">
                              {formatData(recensione.creatoIl)}
                            </span>
                                        </div>

                                        <p className="text-gray-700 leading-relaxed">
                                            {recensione.testo}
                                        </p>

                                        <p className="text-sm text-gray-400 mt-3">
                                            Recensione anonima
                                        </p>
                                    </article>
                                ))}
                            </div>
                        )}

                        {loading && (
                            <p className="text-gray-600 mt-4">
                                Caricamento recensioni...
                            </p>
                        )}

                        {hasMore && (
                            <button
                                type="button"
                                onClick={() => fetchRecensioni(page + 1)}
                                disabled={loading}
                                className="mt-6 bg-gray-900 text-white px-6 py-3 rounded-lg hover:bg-gray-800 disabled:bg-gray-300 font-semibold"
                            >
                                {loading ? 'Caricamento...' : 'Vedi altre recensioni'}
                            </button>
                        )}
                    </section>
                </div>
            </main>
        </PublicLayout>
    )
}