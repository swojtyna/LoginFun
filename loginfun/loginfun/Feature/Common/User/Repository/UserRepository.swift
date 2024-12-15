import Foundation

extension User {
    final class RepositoryImpl: UserRepository {
        @LazyInjected private var userNetworkService: UserNetworkService
        
        private let storage: SecureStorage
        private let tokenKey = "user.token"
        
        init(storage: SecureStorage) {
            self.storage = storage
        }
        
        func login(username: String, password: String) async throws {
            let tokenDTO = try await userNetworkService.login(username: username, password: password)
            storage.set(tokenDTO.token, forKey: tokenKey)
        }
        
        func logout() {
            storage.delete(tokenKey)
        }
        
        func getToken() -> String? {
            storage.get(tokenKey)
        }
        
        var isAuthenticated: Bool {
            getToken() != nil
        }
    }
}
