import UIKit

protocol SceneDelegateCoordinatorService: SceneDelegateService {}

final class SceneDelegateCoordinatorServiceImpl: SceneDelegateCoordinatorService {
    weak var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        appCoordinator = AppCoordinator(windowScene: windowScene)
        appCoordinator?.start()
    }
}
