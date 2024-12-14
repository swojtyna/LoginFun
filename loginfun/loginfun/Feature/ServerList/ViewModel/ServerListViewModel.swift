import Combine

final class ServerListViewModel: ObservableObject {
    private let routeSubject = PassthroughSubject<ServerList.Route, Never>()
    var route: AnyPublisher<ServerList.Route, Never> {
        routeSubject.eraseToAnyPublisher()
    }
}
