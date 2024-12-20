import Foundation

enum Login {
    enum Route {
        case loginSuccess
    }
        
    enum ViewModelState {
        case idle
        case loading
        case error(Swift.Error)
        
        var isLoading: Bool {
            switch self {
            case .loading: true
            default: false
            }
        }
        
        var error: Error? {
            if case let .error(error) = self {
                return error
            }
            return nil
        }
    }
}
