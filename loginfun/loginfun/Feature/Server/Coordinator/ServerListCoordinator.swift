import Combine
import SwiftUI

final class ServerListCoordinator: Coordinator {
    private let navigator: Navigator
    private var cancellables = Set<AnyCancellable>()
    
    init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    func start() {
        let viewModel = Server.ListViewModel()
        let viewController = UIHostingController(rootView: ServerListView(viewModel: viewModel))
        
        viewModel.route
            .receive(on: DispatchQueue.main)
            .sink { [weak self] route in
                self?.handle(route)
            }
            .store(in: &cancellables)

        navigator.push(viewController, animated: true)
    }
}

private extension ServerListCoordinator {
    func handle(_ route: Server.Route) {
        switch route {
        case .logout:
            navigator.pop(animated: true)
        }
    }
}
