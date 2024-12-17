import Foundation

enum User {
    struct Credentials {
        let username: String
        let password: String
    }

    struct AuthToken {
        let value: String
        
        var networkingAuthorization: Networking.Authorization {
            .bearer(token: value)
        }
    }

    enum Error: Swift.Error {
        case noToken
        case invalidCredentials
    }
}

protocol UserRepository {
    var isAuthenticated: Bool { get }
    
    func login(username: String, password: String) async throws
    func logout()
    func getToken() -> User.AuthToken?
}

protocol UserLoginUseCase {
    func execute(username: String, password: String) async throws
}

protocol UserLogoutUseCase {
    func execute()
}

protocol UserGetAuthTokenUseCase {
    func execute() -> String?
}

protocol UserCheckAuthenticationStatusUseCase {
    func execute() -> Bool
}
