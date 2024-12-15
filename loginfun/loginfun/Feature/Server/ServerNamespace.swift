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
    }
    
    // ViewModel
    
    enum ViewModelState {
        case loading
        case loaded([Server.Model])
        case error(Swift.Error)
    }
    
    // Coordiantor
    
    enum Route {}
}

protocol ServerRepository {
    func fetchServers() async throws -> [Server.Model]
}

protocol ServerFetchUseCase {
    func execute() async throws -> [Server.Model]
}
