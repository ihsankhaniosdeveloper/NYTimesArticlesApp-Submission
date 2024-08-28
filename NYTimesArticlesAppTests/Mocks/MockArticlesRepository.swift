//
//  MockArticlesRepository.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import Foundation
import Foundation
@testable import NYTimesArticlesApp

class MockArticlesRepository: ArticlesRepositoryProtocol {
    var result: Result<[DomainArticle], Error>?

    func getMostPopularArticles(endpoint: NYTimesEndpoint, completion: @escaping (Result<[DomainArticle], Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
