import Foundation

protocol ServerNetworkService {
    func fetchServers(token: User.AuthToken) async throws -> [Server.ServersEndpoint.ServerDTO]
}

extension Server {
    final class NetworkServiceImpl: ServerNetworkService {
        @LazyInjected private var apiClient: APIClient

        func fetchServers(token: User.AuthToken) async throws -> [ServersEndpoint.ServerDTO] {
            return try await apiClient.execute(
                ServersEndpoint.servers,
                authorization: token.networkingAuthorization
            )
        }
    }
}
