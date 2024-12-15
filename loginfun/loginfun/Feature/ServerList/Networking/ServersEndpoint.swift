import Foundation

enum ServersEndpoint: Endpoint {
    case servers
    
    var baseURL: String {
        "https://playground.nordsec.com"
    }
    
    var path: String {
        switch self {
        case .servers:
            return "/v1/servers"
        }
    }
    
    var method: Networking.HTTPMethod {
        switch self {
        case .servers:
            return .get
        }
    }
    
    var requiresAuthorization: Bool {
        true
    }
}