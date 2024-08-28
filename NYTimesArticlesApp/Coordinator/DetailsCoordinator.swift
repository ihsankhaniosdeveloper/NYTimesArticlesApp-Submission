//
//  DetailsCoordinator.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 28/08/2024.
//

import Foundation
import UIKit
class DetailsCoordinator: DetailsCoordinatorProtocol {
    
    private let navigationController: UINavigationController
    private let article: DomainArticle
    
    init(navigationController: UINavigationController, article: DomainArticle) {
        self.navigationController = navigationController
        self.article = article
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Instantiate ArticleDetailViewController using its storyboard identifier
        let detailsViewController = storyboard.instantiateViewController(identifier: "ArticleDetailViewController") { coder in
            let detailsViewModel = ArticleDetailsViewModel(article: self.article)
            return ArticleDetailViewController(coder: coder, viewModel: detailsViewModel, coordinator: self)
        }
        navigationController.pushViewController(detailsViewController, animated: true)
    }
    
    func dismissDetails() {
        navigationController.popViewController(animated: true)
    }
}
