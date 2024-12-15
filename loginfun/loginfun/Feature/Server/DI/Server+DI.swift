import Foundation

extension DIContainer {
    static func registerServerLayer() {
        registerServerRepository()
        registerServerUseCases()
    }
}

private extension DIContainer {
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
