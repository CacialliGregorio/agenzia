import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import {
    Facebook,
    Instagram,
    LogIn,
    Mail,
    MapPinned,
    Phone,
    Smartphone,
    Star,
} from 'lucide-react'
import axiosInstance from '../api/axiosInstance'
import WhatsAppTopLink from '../components/WhatsAppTopLink'

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
        <div className="min-h-screen bg-gray-50">
            {/* Top Bar */}
            <div className="bg-gray-900 text-white text-sm py-2">
                <div className="max-w-7xl mx-auto px-4 flex justify-between items-center">
                    <div className="flex items-center gap-4">
                        <WhatsAppTopLink />

                        <a
                            href="https://www.facebook.com/people/Il-Mondo-Immobiliare-Agenzia-Immobiliare/100063610220386/"
                            target="_blank"
                            rel="noopener noreferrer"
                            className="bg-white text-blue-600 p-2 rounded-lg hover:bg-gray-100 transition"
                        >
                            <Facebook className="w-5 h-5" />
                        </a>

                        <a
                            href="https://www.instagram.com/il_mondo_immobiliare/"
                            target="_blank"
                            rel="noopener noreferrer"
                            className="bg-white text-pink-600 p-2 rounded-lg hover:bg-gray-100 transition"
                        >
                            <Instagram className="w-5 h-5" />
                        </a>

                        <span className="text-gray-400">|</span>

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

                    <Link
                        to="/login"
                        className="hover:text-gray-300 flex items-center gap-1"
                    >
                        <LogIn className="w-4 h-4" />
                        Area Dipendenti
                    </Link>
                </div>
            </div>

            {/* Header */}
            <header className="bg-white shadow-md sticky top-0 z-40">
                <div className="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
                    <button
                        type="button"
                        onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}
                        className="cursor-pointer"
                        aria-label="Torna in cima alla pagina"
                    >
                        <img
                            src="/logo.jpeg"
                            alt="Il Mondo Immobiliare"
                            className="h-16 w-auto"
                        />
                    </button>

                    <nav className="hidden md:flex gap-8">
                        <Link to="/" className="text-gray-700 hover:text-blue-600 font-medium">
                            Home
                        </Link>
                        <Link to="/immobili" className="text-gray-700 hover:text-blue-600 font-medium">
                            Immobili
                        </Link>
                        <Link to="/contatti" className="text-gray-700 hover:text-blue-600 font-medium">
                            Contatti
                        </Link>
                        <Link to="/servizi" className="text-gray-700 hover:text-blue-600 font-medium">
                            Servizi
                        </Link>
                        <Link to="/agenzia" className="text-gray-700 hover:text-blue-600 font-medium">
                            Agenzia
                        </Link>
                        <Link to="/recensioni" className="text-blue-600 font-semibold">
                            Recensioni
                        </Link>
                    </nav>
                </div>
            </header>

            {/* Hero */}
            <section className="bg-gray-900 text-white py-20">
                <div className="max-w-7xl mx-auto px-4 text-center">
                    <h1 className="text-4xl md:text-5xl font-bold mb-4">
                        Recensioni
                    </h1>

                    <p className="text-lg text-gray-300 max-w-2xl mx-auto">
                        Lascia una recensione anonima sulla tua esperienza con Il Mondo Immobiliare.
                    </p>
                </div>
            </section>

            {/* Contenuto */}
            <main className="max-w-7xl mx-auto px-4 py-16">
                <div className="grid lg:grid-cols-2 gap-10">
                    {/* Form recensione */}
                    <section className="bg-white rounded-xl shadow-lg p-8">
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
                                        className="bg-white rounded-xl shadow p-6"
                                    >
                                        <div className="flex items-center justify-between gap-4 mb-3">
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

            {/* Footer */}
            <footer className="bg-gray-900 text-white py-12 mt-10">
                <div className="max-w-7xl mx-auto px-4">
                    <div className="grid md:grid-cols-4 gap-8">
                        <div>
                            <img
                                src="/logo.jpeg"
                                alt="Il Mondo Immobiliare"
                                className="h-14 w-auto mb-4"
                            />

                            <p className="text-gray-400 text-sm">
                                Il Mondo Immobiliare - Agenzia immobiliare a Cremona.
                            </p>
                        </div>

                        <div>
                            <h3 className="font-bold mb-4">Contatti</h3>

                            <div className="space-y-2 text-gray-400 text-sm">
                                <p className="flex items-center gap-2">
                                    <Phone className="w-4 h-4" />
                                    0372 32397
                                </p>

                                <p className="flex items-center gap-2">
                                    <Smartphone className="w-4 h-4" />
                                    (+39) 378 4305750
                                </p>

                                <p className="flex items-center gap-2">
                                    <Mail className="w-4 h-4" />
                                    agenzia@ilmondoimmobiliare.eu
                                </p>

                                <p className="flex items-center gap-2">
                                    <MapPinned className="w-4 h-4" />
                                    Via Palestro, 36 - Cremona
                                </p>
                            </div>
                        </div>

                        <div>
                            <h3 className="font-bold mb-4">Menu</h3>

                            <div className="space-y-2 text-sm">
                                <Link to="/" className="block text-gray-400 hover:text-white">
                                    Home
                                </Link>

                                <Link to="/immobili" className="block text-gray-400 hover:text-white">
                                    Immobili
                                </Link>

                                <Link to="/contatti" className="block text-gray-400 hover:text-white">
                                    Contatti
                                </Link>

                                <Link to="/servizi" className="block text-gray-400 hover:text-white">
                                    Servizi
                                </Link>

                                <Link to="/agenzia" className="block text-gray-400 hover:text-white">
                                    Agenzia
                                </Link>

                                <Link to="/recensioni" className="block text-gray-400 hover:text-white">
                                    Recensioni
                                </Link>
                            </div>
                        </div>

                        <div>
                            <h3 className="font-bold mb-4">Seguici</h3>

                            <div className="flex gap-3">
                                <a
                                    href="https://www.facebook.com/people/Il-Mondo-Immobiliare-Agenzia-Immobiliare/100063610220386/"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="bg-white text-blue-600 p-2 rounded-lg hover:bg-gray-100 transition"
                                >
                                    <Facebook className="w-5 h-5" />
                                </a>

                                <a
                                    href="https://www.instagram.com/il_mondo_immobiliare/"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="bg-white text-pink-600 p-2 rounded-lg hover:bg-gray-100 transition"
                                >
                                    <Instagram className="w-5 h-5" />
                                </a>
                            </div>
                        </div>
                    </div>

                    <div className="border-t border-gray-800 mt-8 pt-6 text-sm text-gray-400">
                        © 2017 Il Mondo Immobiliare. All Rights Reserved. Partita IVA:
                        01585350190
                    </div>
                </div>
            </footer>
        </div>
    )
}