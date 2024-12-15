import Foundation

enum ApplicationDependencies {
    static func register() {
        registerAppDelegateLayer()
        registerSceneDelegateLayer()
        registerNetworkingLayer()
        registerDomainLayer()
    }
}

private extension ApplicationDependencies {
    static func registerAppDelegateLayer() {
        DIContainer.register(AppConfigurationService.self, scope: .unique(AppConfigurationServiceImpl()))
        
        DIContainer.register(AppDelegateServicesInjector.self, scope: .application(
            AppDelegateServicesInjectorImpl(services: [
                DIContainer.resolve(AppConfigurationService.self)
            ])
        ))
    }
    
    static func registerSceneDelegateLayer() {
        DIContainer.register(SceneDelegateCoordinatorService.self, scope: .unique(SceneDelegateCoordinatorServiceImpl()))
        
        DIContainer.register(SceneDelegateServicesInjector.self, scope: .application(
            SceneDelegateServicesInjectorImpl(services: [
                DIContainer.resolve(SceneDelegateCoordinatorService.self)
            ])
        ))
    }
    
    static func registerNetworkingLayer() {
        DIContainer.registerNetworkingClient()
    }
    
    static func registerDomainLayer() {
        DIContainer.registerUserLayer()
    }
}
