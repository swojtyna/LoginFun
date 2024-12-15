import Foundation

enum Networking {
    enum Error: Swift.Error {
        case invalidURL
        case networkError(Swift.Error)
        case invalidResponse
        case unauthorized
        case decodingError(Swift.Error)
        case encodingError(Swift.Error)
    }
    
    enum Authorization {
        case none
        case bearer(token: String)
        
        var headerValue: String? {
            switch self {
            case .none:
                return nil
            case .bearer(let token):
                return "Bearer \(token)"
            }
        }
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: Networking.HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Encodable? { get }
    var requiresAuthorization: Bool { get }
    var url: URL? { get }
}

extension Endpoint {
    var headers: [String: String] {
        [:]
    }
    
    var url: URL? {
        guard var components = URLComponents(string: baseURL) else {
            return nil
        }
        components.path += path
        return components.url
    }
    
    var body: Encodable? {
        nil
    }
}

protocol APIClient {
    func execute<T: Decodable>(_ endpoint: Endpoint, authorization: Networking.Authorization) async throws -> T
}
