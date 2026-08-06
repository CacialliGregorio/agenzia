import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom'
import Home from './pages/Home'
import Immobili from './pages/Immobili'
import Contatti from './pages/Contatti'
import Servizi from './pages/Servizi'
import Agenzia from './pages/Agenzia'
import Recensioni from './pages/Recensioni'
import LoginPage from './pages/LoginPage'
import ImmobileDetail from './pages/ImmobileDetail'
import Dashboard from './pages/Dashboard'

const ProtectedRoute = ({ children }) => {
    const token = localStorage.getItem('token')
    return token ? children : <Navigate to="/login" replace />
}

export default function App() {
    return (
        <Router>
            <Routes>
                <Route path="/" element={<Home />} />

                <Route path="/immobili" element={<Immobili />} />

                {/* Pagina dettaglio immobile */}
                <Route path="/immobili/:id" element={<ImmobileDetail />} />

                <Route path="/contatti" element={<Contatti />} />
                <Route path="/servizi" element={<Servizi />} />
                <Route path="/agenzia" element={<Agenzia />} />

                {/* Pagina recensioni */}
                <Route path="/recensioni" element={<Recensioni />} />

                <Route path="/login" element={<LoginPage />} />

                <Route
                    path="/dashboard"
                    element={
                        <ProtectedRoute>
                            <Dashboard />
                        </ProtectedRoute>
                    }
                />

                {/* Se una rotta non esiste, torna alla home */}
                <Route path="*" element={<Navigate to="/" replace />} />
            </Routes>
        </Router>
    )
}