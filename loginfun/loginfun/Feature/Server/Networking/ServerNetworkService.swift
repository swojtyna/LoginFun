import Foundation

protocol ServerNetworkService {
    func fetchServers() async throws -> [Server.ServersEndpoint.ServerDTO]
}

extension Server {
    final class NetworkServiceImpl: ServerNetworkService {
        @LazyInjected private var apiClient: APIClient
        
        func fetchServers() async throws -> [Server.ServersEndpoint.ServerDTO] {
            try await apiClient.execute(
                Server.ServersEndpoint.servers,
                authorization: .bearer(token: "token")
            )
        }
    }
}
