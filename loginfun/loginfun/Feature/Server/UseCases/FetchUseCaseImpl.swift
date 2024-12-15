import Foundation

extension Server {
    final class FetchUseCaseImpl: ServerFetchUseCase {
        @LazyInjected private var repository: ServerRepository
        
        func execute() async throws -> [Server.Model] {
            try await repository.fetchServers()
        }
    }
}
