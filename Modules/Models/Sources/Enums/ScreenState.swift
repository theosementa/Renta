public enum ScreenState<T> {
    case loading
    case success(T)
    case error(AppError)
    case empty
}
