import Foundation

enum Server {
    // Models
    struct Model {
        let name: String
        let distance: Double
    }
    
    enum Error: Swift.Error {
        case invalidData
        case networkError
        case unauthorized
    }
    
    // ViewModel
    
    enum ViewModelState {
        case loading
        case loaded([ServerRowDisplayable])
        case error(Swift.Error)
    }
    
    // Coordinator
    
    enum Route {
        case logout
    }
}

protocol ServerRepository {
    func fetchServers(token: User.AuthToken) async throws -> [Server.Model]
}

protocol ServerFetchUseCase {
    func execute() async throws -> [Server.Model]
}
