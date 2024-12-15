import Foundation

extension Networking {
    final class APIClientImpl: APIClient {
        private let session: URLSession
        
        init(session: URLSession = .shared) {
            self.session = session
        }
        
        func execute<T: Decodable>(_ endpoint: Endpoint, authorization: Authorization = .none) async throws -> T {
            let request = try prepareRequest(for: endpoint, authorization: authorization)
            return try await performRequest(request)
        }
    }
}

private extension Networking.APIClientImpl {
    func prepareRequest(for endpoint: Endpoint, authorization: Networking.Authorization) throws -> URLRequest {
        guard let url = endpoint.url else {
            throw Networking.Error.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        return try request
            .withMethod(endpoint.method.rawValue)
            .withHeaders(endpoint.headers)
            .withAuthorization(for: endpoint, authorization: authorization)
            .withBody(endpoint.body)
    }
    
    func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            return try handleResponse(data: data, response: response)
        } catch let error as DecodingError {
            throw Networking.Error.decodingError(error)
        } catch {
            throw Networking.Error.networkError(error)
        }
    }
    
    func handleResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw Networking.Error.invalidResponse
        }
        
        try validateStatusCode(httpResponse.statusCode)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func validateStatusCode(_ statusCode: Int) throws {
        if statusCode == 401 {
            throw Networking.Error.unauthorized
        }
        
        guard 200...299 ~= statusCode else {
            throw Networking.Error.invalidResponse
        }
    }
}
