import Combine
import Foundation

extension Server {
   final class ListViewModel: ObservableObject {
       @MainActor @Published private(set) var state: ViewModelState = .loading
       
       var route: AnyPublisher<Route, Never> {
           routeSubject.eraseToAnyPublisher()
       }
       private let routeSubject = PassthroughSubject<Route, Never>()
       
       @LazyInjected private var fetchServersUseCase: ServerFetchUseCase
       @LazyInjected private var logoutUseCase: UserLogoutUseCase
       
       private var serversSubscription: AnyCancellable?
       
       @MainActor
       var isFilterEnabled: Bool {
           if case .loaded = state { return true }
           return false
       }
       
       init() {
           Task { @MainActor in
               subscribeToServers { $0 }
           }
       }
       
       @MainActor
       func fetchServers() async {
           state = .loading
           do {
               try await fetchServersUseCase.execute()
           } catch {
               state = .error(error)
           }
       }
       
       func logout() {
           logoutUseCase.execute()
           routeSubject.send(.logout)
       }
       
       @MainActor
       func filterByDistance() {
           subscribeToServers { servers in
               servers.sorted { $0.distance < $1.distance }
           }
       }
       
       @MainActor
       func filterAlphabetically() {
           subscribeToServers { servers in
               servers.sorted { $0.name < $1.name }
           }
       }
   }
}

private extension Server.ListViewModel {
   @MainActor
   func subscribeToServers(_ transform: @escaping ([Server.Model]) -> [Server.Model]) {
       serversSubscription?.cancel()
       serversSubscription = fetchServersUseCase.serversPublisher
           .map(transform)
           .map { servers in
               servers.map { Server.ServerRowDisplayable(name: $0.name, distance: $0.distance) }
           }
           .map(Server.ViewModelState.loaded)
           .receive(on: DispatchQueue.main)
           .sink { [weak self] state in
               self?.state = state
           }
   }
}
