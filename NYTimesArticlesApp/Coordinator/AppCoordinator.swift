//
//  AppCoordinator.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 28/08/2024.
//

import Foundation
import UIKit
class AppCoordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let articlesCoordinator: ArticlesCoordinator
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.articlesCoordinator = ArticlesCoordinator(navigationController: navigationController)
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        articlesCoordinator.start()
    }
}
