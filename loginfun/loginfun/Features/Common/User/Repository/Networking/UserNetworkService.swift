import Foundation

protocol UserNetworkService {
    func login(username: String, password: String) async throws -> User.TokenEndpoint.TokenDTO
}

extension User {
    final class NetworkServiceImpl: UserNetworkService {
        @LazyInjected private var apiClient: APIClient
        
        func login(username: String, password: String) async throws -> TokenEndpoint.TokenDTO {
            let credentials = TokenEndpoint.LoginCredentialsDTO(
                username: username,
                password: password
            )
            return try await apiClient.execute(
                TokenEndpoint.login(credentials),
                authorization: .none
            )
        }
    }
}
