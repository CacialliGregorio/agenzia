import { createContext, useContext, useCallback, useState } from 'react'
import { CheckCircle2, XCircle, X } from 'lucide-react'

const ToastContext = createContext(null)

export function ToastProvider({ children }) {
    const [toasts, setToasts] = useState([])

    const removeToast = useCallback((id) => {
        setToasts((currentToasts) =>
            currentToasts.filter((toast) => toast.id !== id)
        )
    }, [])

    const showToast = useCallback(
        ({
             type = 'success',
             title,
             message = '',
             duration = 4000,
         }) => {
            const id = `${Date.now()}-${Math.random()}`

            const nuovoToast = {
                id,
                type,
                title,
                message,
            }

            setToasts((currentToasts) => [
                ...currentToasts,
                nuovoToast,
            ])

            window.setTimeout(() => {
                removeToast(id)
            }, duration)
        },
        [removeToast]
    )

    const success = useCallback(
        (title, message = '') => {
            showToast({
                type: 'success',
                title,
                message,
            })
        },
        [showToast]
    )

    const error = useCallback(
        (title, message = '') => {
            showToast({
                type: 'error',
                title,
                message,
            })
        },
        [showToast]
    )

    return (
        <ToastContext.Provider
            value={{
                showToast,
                success,
                error,
            }}
        >
            {children}

            <div
                className="fixed top-5 right-5 z-[9999] flex w-[calc(100%-2rem)] max-w-sm flex-col gap-3 pointer-events-none"
                aria-live="polite"
                aria-atomic="true"
            >
                {toasts.map((toast) => {
                    const isSuccess = toast.type === 'success'

                    return (
                        <div
                            key={toast.id}
                            className={`pointer-events-auto overflow-hidden rounded-xl border bg-white shadow-xl ${
                                isSuccess
                                    ? 'border-green-200'
                                    : 'border-red-200'
                            }`}
                        >
                            <div className="flex items-start gap-3 p-4">
                                <div
                                    className={`mt-0.5 flex h-9 w-9 shrink-0 items-center justify-center rounded-full ${
                                        isSuccess
                                            ? 'bg-green-100 text-green-600'
                                            : 'bg-red-100 text-red-600'
                                    }`}
                                >
                                    {isSuccess ? (
                                        <CheckCircle2 className="h-5 w-5" />
                                    ) : (
                                        <XCircle className="h-5 w-5" />
                                    )}
                                </div>

                                <div className="min-w-0 flex-1">
                                    <p
                                        className={`font-bold ${
                                            isSuccess
                                                ? 'text-green-800'
                                                : 'text-red-800'
                                        }`}
                                    >
                                        {toast.title}
                                    </p>

                                    {toast.message && (
                                        <p className="mt-1 text-sm leading-5 text-gray-600">
                                            {toast.message}
                                        </p>
                                    )}
                                </div>

                                <button
                                    type="button"
                                    onClick={() => removeToast(toast.id)}
                                    className="shrink-0 rounded-lg p-1 text-gray-400 transition hover:bg-gray-100 hover:text-gray-700"
                                    aria-label="Chiudi notifica"
                                >
                                    <X className="h-5 w-5" />
                                </button>
                            </div>

                            <div
                                className={`h-1 ${
                                    isSuccess
                                        ? 'bg-green-500'
                                        : 'bg-red-500'
                                }`}
                            />
                        </div>
                    )
                })}
            </div>
        </ToastContext.Provider>
    )
}

export function useToast() {
    const context = useContext(ToastContext)

    if (!context) {
        throw new Error(
            'useToast deve essere utilizzato all’interno di ToastProvider'
        )
    }

    return context
}