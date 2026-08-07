import { Link } from 'react-router-dom'
import {
    Mail,
    MapPinned,
    Phone,
    Smartphone,
} from 'lucide-react'
import { siteConfig } from '../config/siteConfig.js'

export default function PublicFooter() {
    return (
        <>
            {/* Footer verde con contatti */}
            <section className="bg-green-500 text-white">
                <div className="max-w-7xl mx-auto px-4 py-14">
                    <div className="grid grid-cols-1 gap-10 md:grid-cols-3">
                        <div>
                            <h2 className="text-2xl font-bold mb-6">
                                {siteConfig.nomeAgenzia}
                            </h2>

                            <p className="text-lg leading-8">
                                L'agenzia “Il Mondo Immobiliare” offre alla propria clientela un
                                insieme di servizi integrati in grado di soddisfare tutte le
                                esigenze di chi compra, vende, affitta o ricerca un immobile.
                            </p>
                        </div>

                        <div className="text-center">
                            <h2 className="text-2xl font-bold mb-6">F.I.M.A.A.</h2>

                            <img
                                src={siteConfig.fimaaLogo}
                                alt="F.I.M.A.A."
                                className="mx-auto max-h-32 w-auto bg-white p-2 rounded"
                            />
                        </div>

                        <div>
                            <h2 className="text-2xl font-bold mb-6">Contatti</h2>

                            <div className="space-y-3">
                                <a
                                    href={siteConfig.mapsUrl}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="flex items-center bg-green-700/60 hover:bg-green-800/80 transition rounded px-4 py-3"
                                >
                  <span className="w-10 h-10 bg-green-800/80 rounded flex items-center justify-center mr-3 shrink-0">
                    <MapPinned className="w-5 h-5 text-white" />
                  </span>

                                    <span className="font-semibold">
                    {siteConfig.indirizzo}
                  </span>
                                </a>

                                <a
                                    href={siteConfig.telefonoHref}
                                    className="flex items-center bg-green-700/60 hover:bg-green-800/80 transition rounded px-4 py-3"
                                >
                  <span className="w-10 h-10 bg-green-800/80 rounded flex items-center justify-center mr-3 shrink-0">
                    <Phone className="w-5 h-5 text-white" />
                  </span>

                                    <span className="font-semibold">
                    (+39) {siteConfig.telefono}
                  </span>
                                </a>

                                <a
                                    href={siteConfig.cellulareHref}
                                    className="flex items-center bg-green-700/60 hover:bg-green-800/80 transition rounded px-4 py-3"
                                >
                  <span className="w-10 h-10 bg-green-800/80 rounded flex items-center justify-center mr-3 shrink-0">
                    <Smartphone className="w-5 h-5 text-white" />
                  </span>

                                    <span className="font-semibold">
                    (+39) {siteConfig.cellulare}
                  </span>
                                </a>

                                <a
                                    href={siteConfig.emailHref}
                                    className="flex items-center bg-green-700/60 hover:bg-green-800/80 transition rounded px-4 py-3"
                                >
                  <span className="w-10 h-10 bg-green-800/80 rounded flex items-center justify-center mr-3 shrink-0">
                    <Mail className="w-5 h-5 text-white" />
                  </span>

                                    <span className="font-semibold break-all">
                    {siteConfig.email}
                  </span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            {/* Barra finale */}
            <footer className="bg-green-900 text-white">
                <div className="max-w-7xl mx-auto px-4 py-8">
                    <div className="flex flex-col md:flex-row items-center md:items-start justify-between gap-8">
                        <div className="flex flex-col items-start gap-2">
                            <a
                                href={siteConfig.privacyUrl}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="inline-flex items-center gap-1 bg-white text-gray-700 text-xs font-semibold px-2 py-1 rounded shadow hover:bg-gray-100 transition"
                            >
                <span className="inline-flex items-center justify-center w-3 h-3 bg-green-500 text-white rounded-sm text-[9px]">
                  i
                </span>
                                Privacy Policy
                            </a>

                            <a
                                href={siteConfig.cookieUrl}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="inline-flex items-center gap-1 bg-white text-gray-700 text-xs font-semibold px-2 py-1 rounded shadow hover:bg-gray-100 transition"
                            >
                <span className="inline-flex items-center justify-center w-3 h-3 bg-green-500 text-white rounded-sm text-[9px]">
                  i
                </span>
                                Cookie Policy
                            </a>

                            <Link
                                to="/recensioni"
                                className="text-sm text-gray-300 hover:text-white mt-2"
                            >
                                Recensioni
                            </Link>
                        </div>

                        <div className="w-full md:w-1/2 flex justify-center md:justify-end">
                            <img
                                src={siteConfig.logo}
                                alt={siteConfig.nomeAgenzia}
                                className="h-16 md:h-20 w-auto"
                            />
                        </div>
                    </div>
                </div>
            </footer>
        </>
    )
}