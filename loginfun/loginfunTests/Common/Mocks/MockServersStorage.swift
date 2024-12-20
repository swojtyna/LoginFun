import Foundation
@testable import loginfun

final class MockServersStorage: ServersStorage {
    var savedServers: [Server.ServersEndpoint.ServerDTO]?
    
    func getServers() -> [Server.ServersEndpoint.ServerDTO]? {
        savedServers
    }
    
    func save(_ servers: [Server.ServersEndpoint.ServerDTO]) {
        savedServers = servers
    }
}
