import Foundation

private struct Constants {
    static let tokenKey = "user.token"
}

extension User {
    final class RepositoryImpl: UserRepository {
        @LazyInjected private var userNetworkService: UserNetworkService
        @LazyInjected private var storage: SecureStorage
        
        var isAuthenticated: Bool {
            getToken() != nil
        }

        func login(username: String, password: String) async throws {
            let tokenDTO = try await userNetworkService.login(username: username, password: password)
            storage.set(tokenDTO.token, forKey: Constants.tokenKey)
        }
        
        func logout() {
            storage.delete(Constants.tokenKey)
        }
        
        func getToken() -> AuthToken? {
            guard let tokenString = storage.get(Constants.tokenKey) else {
                return nil
            }
            return AuthToken(value: tokenString)
        }
    }
}
