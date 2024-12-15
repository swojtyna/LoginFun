import Foundation

enum User {
    struct Credentials {
        let username: String
        let password: String
    }

    enum Error: Swift.Error {
        case noToken
        case invalidCredentials
    }
}

protocol UserRepository {
    func login(username: String, password: String) async throws
    func logout()
    func getToken() -> String?
    var isAuthenticated: Bool { get }
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
