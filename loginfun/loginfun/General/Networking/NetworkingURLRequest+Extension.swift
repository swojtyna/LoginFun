import Foundation

extension URLRequest {
    func withMethod(_ method: String) -> URLRequest {
        var request = self
        request.httpMethod = method
        return request
    }
    
    func withHeaders(_ headers: [String: String]) -> URLRequest {
        var request = self
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
    
    func withAuthorization(for endpoint: Endpoint, authorization: Networking.Authorization) throws -> URLRequest {
        guard endpoint.requiresAuthorization else { return self }
        
        guard let headerValue = authorization.headerValue else {
            throw Networking.Error.unauthorized
        }
        
        var request = self
        request.setValue(headerValue, forHTTPHeaderField: "Authorization")
        return request
    }
    
    func withBody(_ body: Encodable?) throws -> URLRequest {
        guard let body = body else { return self }
        
        var request = self
        do {
            request.httpBody = try JSONEncoder().encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        } catch {
            throw Networking.Error.encodingError(error)
        }
    }
}
