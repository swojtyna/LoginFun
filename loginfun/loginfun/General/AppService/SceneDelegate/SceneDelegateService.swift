import UIKit

protocol SceneDelegateService: AnyObject {
    var window: UIWindow? { get set }
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
}

extension SceneDelegateService {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {}
}
