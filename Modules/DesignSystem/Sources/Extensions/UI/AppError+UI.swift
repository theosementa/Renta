import Models

public extension AppError {
    var description: String {
        switch self {
        case .itemNotFound:
            return "L'élément demandé est introuvable."
        case .freeTierLimit:
            return "Vous avez atteint la limite du forfait gratuit."
        case .syncFailed:
            return "La synchronisation a échoué. Veuillez réessayer."
        case .purchaseFailed:
            return "L'achat n'a pas pu être effectué. Veuillez réessayer."
        case .notificationsDenied:
            return "Les notifications sont désactivées. Activez-les dans les réglages."
        case .unknown(let message):
            return message
        }
    }
}
