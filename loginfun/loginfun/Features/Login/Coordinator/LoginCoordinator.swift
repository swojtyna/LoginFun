import Combine
import SwiftUI

final class LoginCoordinator: Coordinator {
    private let navigator: Navigator
    private var cancellables = Set<AnyCancellable>()
    private var serverListCoordinator: ServerListCoordinator?

    init(navigator: Navigator) {
        self.navigator = navigator
    }

    func start() -> UIViewController {
        let viewModel = Login.ViewModel()
        let viewController = UIHostingController(rootView: LoginView(viewModel: viewModel))

        viewModel.route
            .receive(on: DispatchQueue.main)
            .sink { [weak self] route in
                self?.handle(route)
            }
            .store(in: &cancellables)

        return viewController
    }

    private func handle(_ route: Login.Route) {
        switch route {
        case .loginSuccess:
            showServerList()
        }
    }

    private func showServerList() {
        let coordinator = ServerListCoordinator(navigator: navigator)
        serverListCoordinator = coordinator
        let viewController = coordinator.start()
        navigator.push(viewController, animated: true)
    }
}
