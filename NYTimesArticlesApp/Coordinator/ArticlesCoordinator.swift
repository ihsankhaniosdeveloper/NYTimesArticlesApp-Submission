//
//  ArticleCoordinator.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 28/08/2024.
//

import Foundation
import UIKit

class ArticlesCoordinator: ArticlesCoordinatorProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Instantiate ArticlesViewController using the custom initializer
        let articlesViewController = storyboard.instantiateViewController(identifier: "ArticlesViewController", creator: { coder in
            let repository = ArticlesRepository(networkDataSource: NYNetworkManager())
            let useCase = FetchMostPopularArticlesUseCase(repository: repository)
            let viewModel = ArticlesViewModel(fetchMostPopularArticlesUseCase: useCase)
            return ArticlesViewController(coder: coder, viewModel: viewModel, coordinator: self)
        })
        // Set the root view controller
        navigationController.setViewControllers([articlesViewController], animated: false)
    }
    
    func showArticleDetails(for article: DomainArticle) {
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController, article: article)
        detailsCoordinator.start()
    }
    
}
