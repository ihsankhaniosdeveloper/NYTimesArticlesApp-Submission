//
//  CoordinatorProtocols.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 28/08/2024.
//

import Foundation
protocol ArticlesCoordinatorProtocol: AnyObject {
    func showArticleDetails(for article: DomainArticle)
}
 protocol DetailsCoordinatorProtocol: AnyObject {
    func dismissDetails()
}
