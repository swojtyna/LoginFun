import Foundation

extension DIContainer {
    static func registerServerLayer() {
        registerStorages()
        registerNetworkServices()
        registerServerRepository()
        registerServerUseCases()
    }
}

private extension DIContainer {
    static func registerStorages() {
        register(
            ServersStorage.self,
            scope: .unique(ServersUserDefaultsStorage())
        )
    }
    
    static func registerNetworkServices() {
        register(
            ServerNetworkService.self,
            scope: .unique(Server.NetworkServiceImpl())
        )
    }
    
    static func registerServerRepository() {
        register(
            ServerRepository.self,
            scope: .unique(Server.RepositoryImpl())
        )
    }
    
    static func registerServerUseCases() {
        register(
            ServerFetchUseCase.self,
            scope: .unique(Server.FetchUseCaseImpl())
        )
    }
}
