import Foundation

/// Protocol defining interface for secure storage operations.
/// This is a temporary solution using UserDefaults for simplicity.
/// In a production environment, sensitive data like authentication tokens
/// should be stored in the Keychain for better security.
protocol SecureStorage {
   func get(_ key: String) -> String?
   func set(_ value: String, forKey key: String)
   func delete(_ key: String)
}

/// Basic implementation using UserDefaults for demonstration purposes.
/// Should be replaced with KeychainWrapper or similar secure storage solution in production.
final class UserDefaultsStorage: SecureStorage {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func get(_ key: String) -> String? {
        userDefaults.string(forKey: key)
    }
    
    func set(_ value: String, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func delete(_ key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
