import XCTest
@testable import loginfun

final class MockAPIClient: APIClient {
    private var responses: [String: Any] = [:]
    private var errors: [String: Error] = [:]
    
    func mockResponse<T: Encodable>(_ response: T, for endpoint: Endpoint) {
        let key = "\(endpoint.method.rawValue)_\(endpoint.baseURL)\(endpoint.path)"
        responses[key] = response
    }
    
    func mockError(_ error: Error, for endpoint: Endpoint) {
        let key = "\(endpoint.method.rawValue)_\(endpoint.baseURL)\(endpoint.path)"
        errors[key] = error
    }
    
    func execute<T: Decodable>(_ endpoint: Endpoint, authorization: Networking.Authorization) async throws -> T {
        let key = "\(endpoint.method.rawValue)_\(endpoint.baseURL)\(endpoint.path)"
        
        if let error = errors[key] {
            throw error
        }
        
        guard let response = responses[key] as? T else {
            throw Networking.Error.invalidResponse
        }
        
        return response
    }
}
