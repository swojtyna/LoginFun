import Combine

extension Server {
    final class ListViewModel: ObservableObject {
        @MainActor @Published private(set) var state: Server.ViewModelState = .loading
        
        private let routeSubject = PassthroughSubject<Server.Route, Never>()
        var route: AnyPublisher<Server.Route, Never> {
            routeSubject.eraseToAnyPublisher()
        }
        
        @LazyInjected private var fetchServersUseCase: ServerFetchUseCase
        @LazyInjected private var logoutUseCase: UserLogoutUseCase
        
        @MainActor
        func fetchServers() async {
            state = .loading
            do {
                let servers = try await fetchServersUseCase.execute()
                let displayableServers = servers.map { model in
                    ServerRowDisplayable(
                        name: model.name,
                        distance: model.distance
                    )
                }
                state = .loaded(displayableServers)
            } catch {
                state = .error(error)
            }
        }
        
        func logout() {
            logoutUseCase.execute()
            routeSubject.send(.logout)
        }
        
        func filter() {
            // tbi
        }
    }
}
