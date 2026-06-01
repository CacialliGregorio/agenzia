export default function WhatsAppTopLink() {
    const numeroWhatsapp = '393294011384'

    const messaggio = encodeURIComponent(
        'Ciao, vorrei ricevere informazioni da Il Mondo Immobiliare.'
    )

    return (
        <a
            href={`https://wa.me/${numeroWhatsapp}?text=${messaggio}`}
            target="_blank"
            rel="noopener noreferrer"
            className="flex flex-col items-center justify-center gap-0.5 group"
            title="Scrivici su WhatsApp"
        >
      <span className="bg-white rounded-lg p-1.5 flex items-center justify-center hover:bg-green-100 transition">
        <svg
            viewBox="0 0 32 32"
            className="w-5 h-5"
            aria-hidden="true"
        >
          <path
              fill="#25D366"
              d="M16.01 3C8.83 3 3 8.82 3 15.99c0 2.29.6 4.52 1.74 6.48L3 29l6.69-1.7A12.9 12.9 0 0 0 16.01 29C23.18 29 29 23.18 29 15.99S23.18 3 16.01 3Z"
          />
          <path
              fill="#FFFFFF"
              d="M23.44 19.36c-.31.87-1.54 1.59-2.45 1.8-.65.15-1.5.27-4.36-.91-3.66-1.52-6.02-5.24-6.2-5.48-.18-.24-1.48-1.97-1.48-3.76s.94-2.67 1.27-3.04c.33-.37.72-.46.96-.46h.69c.22 0 .52-.08.81.62.31.75 1.05 2.58 1.14 2.77.09.19.15.41.03.65-.12.24-.18.39-.36.6-.18.21-.38.47-.54.63-.18.18-.37.38-.16.75.21.37.94 1.55 2.02 2.51 1.39 1.24 2.56 1.62 2.93 1.8.37.18.59.15.81-.09.22-.24.93-1.08 1.18-1.45.25-.37.5-.31.84-.18.34.12 2.17 1.02 2.54 1.2.37.18.62.27.71.42.09.15.09.87-.22 1.74Z"
          />
        </svg>
      </span>

        </a>
    )
}