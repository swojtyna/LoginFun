import Foundation

extension DIContainer {
    static func registerServerLayer() {
        registerNetworkServices()
        registerServerRepository()
        registerServerUseCases()
    }
}

private extension DIContainer {
    static func registerNetworkServices() {
        register(
            ServerNetworkService.self,
            scope: .application(Server.NetworkServiceImpl())
        )
    }
    
    static func registerServerRepository() {
        register(
            ServerRepository.self,
            scope: .application(Server.RepositoryImpl())
        )
    }
    
    static func registerServerUseCases() {
        register(
            ServerFetchUseCase.self,
            scope: .unique(Server.FetchUseCaseImpl())
        )
    }
}
