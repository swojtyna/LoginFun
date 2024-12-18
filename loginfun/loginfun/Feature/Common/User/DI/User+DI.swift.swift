import Foundation

extension DIContainer {
    static func registerUserLayer() {
        registerStorages()
        registerNetworkServices()
        registerUserRepository()
        registerUserUseCases()
    }
}

private extension DIContainer {
    
    static func registerStorages() {
        register(
            SecureStorage.self,
            scope: .unique(UserDefaultsStorage())
        )
    }
    
    static func registerNetworkServices() {
        register(
            UserNetworkService.self,
            scope: .unique(User.NetworkServiceImpl())
        )
    }
    
    static func registerUserRepository() {
        register(
            UserRepository.self,
            scope: .application(User.RepositoryImpl())
        )
    }

    static func registerUserUseCases() {
        register(
            UserLoginUseCase.self,
            scope: .unique(User.LoginUseCaseImpl())
        )
        
        register(
            UserLogoutUseCase.self,
            scope: .unique(User.LogoutUseCaseImpl())
        )

        register(
            UserCheckAuthenticationStatusUseCase.self,
            scope: .unique(User.CheckAuthenticationStatusUseCaseImpl())
        )
    }
    

}

