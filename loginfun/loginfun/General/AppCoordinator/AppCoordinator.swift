import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let navigator: NavigationControllerNavigator
    private var loginCoordinator: LoginCoordinator?
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
        self.navigator = NavigationControllerNavigator(navigationController: UINavigationController())
    }
    
    func start() {
        window.rootViewController = navigator.navigationController
        window.makeKeyAndVisible()
        
        showLogin()
    }
}

private extension AppCoordinator {
    func showLogin() {
        let coordinator = LoginCoordinator(navigator: navigator)
        loginCoordinator = coordinator
        coordinator.start()
    }
}
