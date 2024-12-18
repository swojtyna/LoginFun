import Foundation

protocol ServersStorage {
    func getServers() -> [Server.ServersEndpoint.ServerDTO]?
    func save(_ servers: [Server.ServersEndpoint.ServerDTO])
}

final class ServersUserDefaultsStorage: ServersStorage {
    private let key = "stored_servers"
    
    func getServers() -> [Server.ServersEndpoint.ServerDTO]? {
        guard let data = UserDefaults.standard.data(forKey: key),
              let servers = try? JSONDecoder().decode([Server.ServersEndpoint.ServerDTO].self, from: data) else {
            return nil
        }
        return servers
    }
    
    func save(_ servers: [Server.ServersEndpoint.ServerDTO]) {
        guard let data = try? JSONEncoder().encode(servers) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
