import Foundation

protocol ServersNetworkService {
    func fetchServers() async throws -> [ServerDTO]
}

final class ServersNetworkServiceImpl: ServersNetworkService {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchServers() async throws -> [ServerDTO] {
        try await apiClient.execute(ServersEndpoint.servers, authorization: .none)
    }
}
