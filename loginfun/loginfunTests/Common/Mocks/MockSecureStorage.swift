import Foundation
@testable import loginfun

final class MockSecureStorage: SecureStorage {
    private var storage: [String: String] = [:]
    
    func get(_ key: String) -> String? {
        storage[key]
    }
    
    func set(_ value: String, forKey key: String) {
        storage[key] = value
    }
    
    func delete(_ key: String) {
        storage[key] = nil
    }
}
