import Foundation

extension User {
    enum TokenEndpoint: Endpoint {
        // MARK: - DTOs
        struct LoginCredentialsDTO: Codable {
            let username: String
            let password: String
        }
        
        struct TokenDTO: Codable {
            let token: String
        }
        
        // MARK: - Cases
        case login(LoginCredentialsDTO)
        
        var baseURL: String {
            "https://playground.nordsec.com"
        }
        
        var path: String {
            switch self {
            case .login:
                return "/v1/tokens"
            }
        }
        
        var method: Networking.HTTPMethod {
            switch self {
            case .login:
                return .post
            }
        }
        
        var body: Encodable? {
            switch self {
            case let .login(credentials):
                return credentials
            }
        }
        
        var requiresAuthorization: Bool {
            false
        }
    }
}
