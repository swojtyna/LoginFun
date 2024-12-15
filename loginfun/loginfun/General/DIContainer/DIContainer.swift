import Foundation
import SwiftUI

final class DIContainer {

    enum ObjectScope<Object> {
        case unique(@autoclosure () -> Object)
        case application(Object)
    }

    static let container = DIContainer()

    private init() {}
    private var storage: [String: Any] = [:]

    static func resolve<T>(_ type: T.Type = T.self) -> T {
        let key = String(describing: type)
        
        guard let objectScope = container.storage[key] as? ObjectScope<T> else {
            fatalError("📛\(key) not found - check if you have correct registration!")
        }

        switch objectScope {
        case .unique(let createDependency): return createDependency()
        case .application(let dependency): return dependency
        }
    }

    static func register<T>(_ type: T.Type, scope: ObjectScope<T>) {
        let key = String(describing: T.self)
        container.storage[key] = scope
    }

    static func replace<T>(_ type: T.Type, scope: ObjectScope<T>) {
        let key = String(describing: T.self)

        guard container.storage[key] != nil else {
            fatalError("📛\(key) not found - check if you have correct registration!")
        }

        container.storage[key] = scope
    }
}

@propertyWrapper
struct Injected<Value> {
    private let value = DIContainer.resolve(Value.self)
    init() {}
    var wrappedValue: Value { value }
}

@propertyWrapper
struct LazyInjected<Value> {
    private lazy var value = DIContainer.resolve(Value.self)
    init() {}
    var wrappedValue: Value {
        mutating get { value }
    }
}

@propertyWrapper
final class InjectedObservable<Value>: DynamicProperty {
    @State private var value: Value = DIContainer.resolve(Value.self)

    var wrappedValue: Value {
        get { return value }
        set { value = newValue }
    }

    init() { }
}
