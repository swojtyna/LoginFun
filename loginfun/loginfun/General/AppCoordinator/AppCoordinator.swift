import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let navigator: NavigationControllerNavigator
    private var loginCoordinator: LoginCoordinator?
    private var serverListCoordinator: ServerListCoordinator?
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        self.navigator = NavigationControllerNavigator(navigationController: navigationController)
    }
    
    func start() -> UIViewController {
        fatalError("Use startWithLogin() or startWithServerList()")
    }
    
    func startWithLogin() -> UIViewController {
        window.rootViewController = navigator.navigationController
        window.makeKeyAndVisible()
        
        let coordinator = LoginCoordinator(navigator: navigator)
        loginCoordinator = coordinator
        let viewController = coordinator.start()
        navigator.setRoot([viewController], animated: false)
        return viewController
    }
    
    func startWithServerList() -> UIViewController {
        window.rootViewController = navigator.navigationController
        window.makeKeyAndVisible()
        
        let loginCoordinator = LoginCoordinator(navigator: navigator)
        let loginViewController = loginCoordinator.start()
        
        let serverCoordinator = ServerListCoordinator(navigator: navigator)
        serverListCoordinator = serverCoordinator
        let serverViewController = serverCoordinator.start()
        
        navigator.setRoot([loginViewController, serverViewController], animated: false)
        return serverViewController
    }
}
