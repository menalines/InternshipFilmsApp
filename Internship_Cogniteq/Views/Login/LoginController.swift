//
//  LoginView.swift
//  Internship_Cogniteq
//
//  Created by Siarova Katsiaryna on 5.03.21.

import SwiftUI
import UIKit

protocol LoginViewProtocol {
    func openMainView()
}

final class LoginController: UIHostingController<LoginView>, LoginViewProtocol {
    private let state = LoginState()
    
    init() {
        let view = LoginView(state: state)
        super.init(rootView: view)
        state.controller = self
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        let view = LoginView(state: state)
        super.init(coder: aDecoder, rootView: view)
        state.controller = self
    }
    
    func openMainView() {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            let tabController = UITabBarController()
            let films = FilmsController()
            let search = SearchController()
            
            films.tabBarItem = UITabBarItem(title: "Popular", image: UIImage(systemName: "star"), tag: 0)
            search.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
            
            let controllers = [films, search]
            tabController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
            
            sceneDelegate.window?.rootViewController = tabController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
}
