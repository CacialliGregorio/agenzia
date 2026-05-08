import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom'
import Home from './pages/Home'
import Immobili from './pages/Immobili'
import Contatti from './pages/Contatti'
import Servizi from './pages/Servizi'
import Agenzia from './pages/Agenzia'
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
        <Route path="/contatti" element={<Contatti />} />
        <Route path="/servizi" element={<Servizi />} />
        <Route path="/agenzia" element={<Agenzia />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/annuncio/:id" element={<ImmobileDetail />} />
        <Route
          path="/dashboard"
          element={
            <ProtectedRoute>
              <Dashboard />
            </ProtectedRoute>
          }
        />
      </Routes>
    </Router>
  )
}

