import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    @LazyInjected private var servicesInjector: AppDelegateServicesInjector
    private var services: [AppDelegateService] = []
    
    override init() {
        ApplicationDependencies.register()
        super.init()
        services = servicesInjector.services
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        services.map { $0.application(application, didFinishLaunchingWithOptions: launchOptions) }.allTrue
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        services.reduce(UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)) { _ , service in
            service.application(application, configurationForConnecting: connectingSceneSession, options: options)
        }
    }
}
