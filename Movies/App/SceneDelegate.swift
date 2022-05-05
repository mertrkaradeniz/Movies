//
//  SceneDelegate.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let splash = SplashRouter.setupModule()
        window.makeKeyAndVisible()
        window.rootViewController = splash
        self.window = window
    }
}

