import Foundation

extension Server {
    final class RepositoryImpl: ServerRepository {
        @LazyInjected private var networkService: ServerNetworkService
        
        func fetchServers() async throws -> [Server.Model] {
            let dtos = try await networkService.fetchServers()
            return dtos.map { Server.Model(name: $0.name, distance: $0.distance) }
        }
    }
}
