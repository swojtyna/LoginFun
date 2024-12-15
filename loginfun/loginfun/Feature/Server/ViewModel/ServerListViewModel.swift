import Combine

final class ServerListViewModel: ObservableObject {
    @Published private(set) var state: Server.ViewModelState = .loading
    
    private let routeSubject = PassthroughSubject<Server.Route, Never>()
    var route: AnyPublisher<Server.Route, Never> {
        routeSubject.eraseToAnyPublisher()
    }
    
    @Injected private var fetchServersUseCase: ServerFetchUseCase
    
    func fetchServers() async {
        state = .loading
        do {
            let servers = try await fetchServersUseCase.execute()
            state = .loaded(servers)
        } catch {
            state = .error(error)
        }
    }
}
