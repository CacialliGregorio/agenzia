import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import {
    Facebook,
    Instagram,
    LogIn,
    Menu,
    Phone,
    Plus,
    X,
} from 'lucide-react'
import WhatsAppTopLink from './WhatsAppTopLink'
import { siteConfig } from '../config/siteConfig.js'

export default function PublicHeader({ activePage }) {
    const [menuOpen, setMenuOpen] = useState(false)

    const navigate = useNavigate()
    const token = localStorage.getItem('token')

    const menuItems = [
        { label: 'Home', path: '/', key: 'home' },
        { label: 'Immobili', path: '/immobili', key: 'immobili' },
        { label: 'Contatti', path: '/contatti', key: 'contatti' },
        { label: 'Servizi', path: '/servizi', key: 'servizi' },
        { label: 'Agenzia', path: '/agenzia', key: 'agenzia' },
        { label: 'Recensioni', path: '/recensioni', key: 'recensioni' },
    ]

    const handleLogoClick = () => {
        window.scrollTo({
            top: 0,
            behavior: 'smooth',
        })

        setMenuOpen(false)
    }

    const handleAreaDipendenti = () => {
        setMenuOpen(false)

        if (token) {
            navigate('/dashboard')
        } else {
            navigate('/login')
        }
    }

    const getDesktopLinkClassName = (key) => {
        if (activePage === key) {
            return 'text-blue-600 font-semibold'
        }

        return 'text-gray-700 hover:text-blue-600 font-medium'
    }

    const getMobileLinkClassName = (key) => {
        if (activePage === key) {
            return 'block px-4 py-3 rounded-lg bg-blue-50 text-blue-600 font-semibold'
        }

        return 'block px-4 py-3 rounded-lg text-gray-700 hover:bg-gray-100 font-medium'
    }

    return (
        <>
            {/* Top Bar Desktop */}
            <div className="hidden md:block bg-gray-900 text-white text-sm py-2">
                <div className="max-w-7xl mx-auto px-4 flex justify-between items-center">
                    <div className="flex gap-4 items-center">
                        <WhatsAppTopLink />

                        <a
                            href={siteConfig.facebookUrl}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="bg-white rounded-lg p-1.5 flex items-center justify-center hover:bg-blue-100 transition"
                            aria-label="Facebook"
                        >
                            <Facebook className="w-5 h-5 text-blue-600" />
                        </a>

                        <a
                            href={siteConfig.instagramUrl}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="bg-white rounded-lg p-1.5 flex items-center justify-center hover:bg-pink-100 transition"
                            aria-label="Instagram"
                        >
                            <Instagram className="w-5 h-5 text-pink-500" />
                        </a>

                        <span className="mx-2 h-5 w-px bg-gray-400 inline-block"></span>

                        <a href={siteConfig.telefonoHref} className="hover:text-gray-300">
                            📞 {siteConfig.telefono}
                        </a>

                        <a href={siteConfig.emailHref} className="hover:text-gray-300">
                            ✉️ {siteConfig.email}
                        </a>
                    </div>

                    <button
                        type="button"
                        onClick={handleAreaDipendenti}
                        className="hover:text-gray-300 flex items-center gap-1"
                    >
                        {token ? (
                            <>
                                <Plus className="w-4 h-4" />
                                Dashboard
                            </>
                        ) : (
                            <>
                                <LogIn className="w-4 h-4" />
                                Area Dipendenti
                            </>
                        )}
                    </button>
                </div>
            </div>

            {/* Top Bar Mobile */}
            <div className="md:hidden bg-gray-900 text-white text-sm py-2">
                <div className="px-4 flex justify-between items-center">
                    <div className="flex items-center gap-3">
                        <WhatsAppTopLink />

                        <a
                            href={siteConfig.telefonoHref}
                            className="flex items-center gap-1 hover:text-gray-300"
                        >
                            <Phone className="w-4 h-4" />
                            Chiama
                        </a>
                    </div>

                    <button
                        type="button"
                        onClick={handleAreaDipendenti}
                        className="hover:text-gray-300 flex items-center gap-1"
                    >
                        {token ? (
                            <>
                                <Plus className="w-4 h-4" />
                                Dashboard
                            </>
                        ) : (
                            <>
                                <LogIn className="w-4 h-4" />
                                Area
                            </>
                        )}
                    </button>
                </div>
            </div>

            {/* Header */}
            <header className="bg-white shadow-sm sticky top-0 z-40">
                <div className="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
                    <button
                        type="button"
                        onClick={handleLogoClick}
                        className="cursor-pointer"
                        aria-label="Torna in cima alla pagina"
                    >
                        <img
                            src={siteConfig.logo}
                            alt={siteConfig.nomeAgenzia}
                            className="h-12 md:h-16 w-auto"
                        />
                    </button>

                    {/* Menu Desktop */}
                    <nav className="hidden md:flex gap-6">
                        {menuItems.map((item) => (
                            <Link
                                key={item.key}
                                to={item.path}
                                className={getDesktopLinkClassName(item.key)}
                            >
                                {item.label}
                            </Link>
                        ))}
                    </nav>

                    {/* Bottone Mobile */}
                    <button
                        type="button"
                        onClick={() => setMenuOpen((prev) => !prev)}
                        className="md:hidden inline-flex items-center justify-center p-2 rounded-lg border border-gray-300 text-gray-700"
                        aria-label="Apri menu"
                    >
                        {menuOpen ? (
                            <X className="w-6 h-6" />
                        ) : (
                            <Menu className="w-6 h-6" />
                        )}
                    </button>
                </div>

                {/* Menu Mobile */}
                {menuOpen && (
                    <nav className="md:hidden border-t bg-white shadow-lg">
                        <div className="px-4 py-4 space-y-2">
                            {menuItems.map((item) => (
                                <Link
                                    key={item.key}
                                    to={item.path}
                                    onClick={() => setMenuOpen(false)}
                                    className={getMobileLinkClassName(item.key)}
                                >
                                    {item.label}
                                </Link>
                            ))}
                        </div>
                    </nav>
                )}
            </header>
        </>
    )
}