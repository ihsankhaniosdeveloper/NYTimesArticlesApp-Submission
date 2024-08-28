//
//  FetchMostPopularArticlesUseCase.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation

protocol FetchMostPopularArticlesUseCaseProtocol {
    func loadArticles(endpoint: NYTimesEndpoint, completion: @escaping (Result<[DomainArticle], Error>) -> Void)
}
class FetchMostPopularArticlesUseCase: FetchMostPopularArticlesUseCaseProtocol {
    
    private let repository: ArticlesRepositoryProtocol
    
    
    init(repository: ArticlesRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadArticles(endpoint: NYTimesEndpoint, completion: @escaping (Result<[DomainArticle], Error>) -> Void) {
        self.repository.getMostPopularArticles(endpoint: endpoint) { result in
            completion(result)
            
        }
    }
    
}

