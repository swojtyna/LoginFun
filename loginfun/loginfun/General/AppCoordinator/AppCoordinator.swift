import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let navigator: NavigationControllerNavigator
    private var loginCoordinator: LoginCoordinator?
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        
        self.navigator = NavigationControllerNavigator(navigationController: navigationController)
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
