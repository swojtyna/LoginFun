import Foundation

extension User {
    final class CheckAuthenticationStatusUseCaseImpl: UserCheckAuthenticationStatusUseCase {
        @LazyInjected private var repository: UserRepository
        
        func execute() -> Bool {
            repository.isAuthenticated
        }
    }
}
