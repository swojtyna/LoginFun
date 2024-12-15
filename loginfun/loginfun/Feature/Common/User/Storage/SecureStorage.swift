import Foundation

// Temporary solution
protocol SecureStorage {
    func get(_ key: String) -> String?
    func set(_ value: String, forKey key: String)
    func delete(_ key: String)
}

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
