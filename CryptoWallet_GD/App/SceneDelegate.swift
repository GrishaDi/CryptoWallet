//
//  SceneDelegate.swift
//  CryptoWallet_GD
//
//  Created by Grisha Diehl on 23.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navVC = UINavigationController()
        let coordinator = MainCoordinator()
        coordinator.navigationController = navVC
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = .dark
        self.window = window
        
        coordinator.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}

