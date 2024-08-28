//
//  FetchMostPopularArticlesUseCaseProtocol.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 28/08/2024.
//

import Foundation
@testable import NYTimesArticlesApp
class MockFetchMostPopularArticlesUseCase: FetchMostPopularArticlesUseCaseProtocol {
    var result: Result<[DomainArticle], Error>?
    
    func loadArticles(endpoint: NYTimesEndpoint, completion: @escaping (Result<[DomainArticle], Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
