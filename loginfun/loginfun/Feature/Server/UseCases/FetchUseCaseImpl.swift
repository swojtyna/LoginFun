import Foundation

extension Server {
    final class FetchUseCaseImpl: ServerFetchUseCase {
        @LazyInjected private var repository: ServerRepository
        @LazyInjected private var userRepository: UserRepository
        
        func execute() async throws -> [Server.Model] {
            guard let token = userRepository.getToken() else {
                throw Server.Error.unauthorized
            }
            return try await repository.fetchServers(token: token)
        }
    }
}
