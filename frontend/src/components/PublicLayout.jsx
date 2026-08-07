import PublicHeader from './PublicHeader'
import PublicFooter from './PublicFooter'

export default function PublicLayout({ activePage, children }) {
    return (
        <div className="min-h-screen bg-gray-50">
            <PublicHeader activePage={activePage} />

            {children}

            <PublicFooter />
        </div>
    )
}