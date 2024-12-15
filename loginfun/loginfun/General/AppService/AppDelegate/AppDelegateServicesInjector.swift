import Foundation

final class AppDelegateServicesInjectorImpl: AppDelegateServicesInjector {
    private(set) var services: [AppDelegateService]
    
    init(services: [AppDelegateService]) {
        self.services = services
    }
}
