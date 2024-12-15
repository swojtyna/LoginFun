import Foundation

protocol SceneDelegateServicesInjector {
    var services: [SceneDelegateService] { get }
}

final class SceneDelegateServicesInjectorImpl: SceneDelegateServicesInjector {
    private(set) var services: [SceneDelegateService]
    
    init(services: [SceneDelegateService]) {
        self.services = services
    }
}
