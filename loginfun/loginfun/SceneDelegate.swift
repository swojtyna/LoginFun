//
//  SceneDelegate.swift
//  loginfun
//
//  Created by Sebastian Wojtyna on 14/12/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
        private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        appCoordinator = AppCoordinator(windowScene: windowScene)
        appCoordinator?.start()
    }
}
