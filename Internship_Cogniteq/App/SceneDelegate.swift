//
//  SceneDelegate.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 5.03.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = LoginController()
        self.window = window
        window.makeKeyAndVisible()
    }
}

