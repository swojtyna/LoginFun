import Foundation

/// Protocol for storing server data locally.
/// This implementation uses UserDefaults for simplicity and demonstration purposes.
/// For production, consider using more robust solutions like Core Data, Realm,
/// or other persistence frameworks that better handle data migrations and complex object graphs.
protocol ServersStorage {
   func getServers() -> [Server.ServersEndpoint.ServerDTO]?
   func save(_ servers: [Server.ServersEndpoint.ServerDTO])
}

/// Basic implementation using UserDefaults and JSON encoding/decoding.
/// While sufficient for this demo, a production app might need:
/// - Better error handling
/// - Data migration support
/// - More efficient storage for large datasets
/// - Better separation of concerns (DTO vs domain models storage)
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
