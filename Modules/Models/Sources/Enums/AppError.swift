public enum AppError: Error {
    case itemNotFound
    case freeTierLimit
    case syncFailed
    case purchaseFailed
    case notificationsDenied
    case unknown(String)
}
