import Foundation
import Combine

extension Server {
    final class FetchUseCaseImpl: ServerFetchUseCase {
        @LazyInjected private var repository: ServerRepository
        @LazyInjected private var userRepository: UserRepository
        var serversPublisher: AnyPublisher<[Server.Model], Never> {
            repository.serversPublisher
        }
        
        func execute() async throws {
            guard let token = userRepository.getToken() else {
                throw Server.Error.unauthorized
            }
            try await repository.fetchServers(token: token)
        }
    }
}
