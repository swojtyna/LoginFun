import Foundation

extension User {
    final class LoginUseCaseImpl: UserLoginUseCase {
        @LazyInjected private var repository: UserRepository
        
        func execute(username: String, password: String) async throws {
            try await repository.login(username: username, password: password)
        }
    }
}
