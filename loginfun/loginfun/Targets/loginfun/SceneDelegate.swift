import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    @LazyInjected private var servicesInjector: SceneDelegateServicesInjector
    private var services: [SceneDelegateService] = []
    
    override init() {
        super.init()
        self.services = servicesInjector.services
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        services.forEach { $0.window = window }
        services.forEach { $0.scene(scene, willConnectTo: session, options: connectionOptions) }
    }
}
