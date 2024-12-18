import Combine
import Foundation

extension Server {
    final class RepositoryImpl: ServerRepository {
        private let serversSubject = CurrentValueSubject<[Server.Model], Never>([])
        var serversPublisher: AnyPublisher<[Server.Model], Never> {
            serversSubject.eraseToAnyPublisher()
        }

        @LazyInjected private var networkService: ServerNetworkService
        @LazyInjected private var storage: ServersStorage

        init() {
            setupFromStorage()
        }

        func fetchServers(token: User.AuthToken) async throws {
            let servers = try await networkService.fetchServers(token: token)
            let models = servers.map { Server.Model(name: $0.name, distance: $0.distance) }
            storage.save(servers)
            serversSubject.send(models)
        }
    }
}

private extension Server.RepositoryImpl {
    func setupFromStorage() {
        if let cachedServers = storage.getServers() {
            serversSubject.send(cachedServers.map { Server.Model(name: $0.name, distance: $0.distance) })
        }
    }
}
