import Foundation

extension User {
    final class LogoutUseCaseImpl: UserLogoutUseCase {
        @LazyInjected private var repository: UserRepository
        
        func execute() {
            repository.logout()
        }
    }
}
