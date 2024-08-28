//
//  MostPopularArticlesViewModel.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation
import Combine

protocol ArticlesViewModelProtocol: AnyObject {
    var articlesPublisher: Published<[DomainArticle]>.Publisher { get }
    var errorMessagePublisher: Published<String?>.Publisher { get }

    func loadArticles(section: String, period: Int)
    func getNumberOfRowsInSections() -> Int
    func getArticle(index: Int) -> DomainArticle?
}

class ArticlesViewModel: ArticlesViewModelProtocol {
    private let fetchMostPopularArticlesUseCase: FetchMostPopularArticlesUseCaseProtocol
    private let networkReachabilityService: NetworkReachabilityServiceProtocol

    @Published private(set) var articles: [DomainArticle] = []
    @Published private(set) var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    
    init(fetchMostPopularArticlesUseCase: FetchMostPopularArticlesUseCaseProtocol, networkReachabilityService: NetworkReachabilityServiceProtocol) {
        self.fetchMostPopularArticlesUseCase = fetchMostPopularArticlesUseCase
        self.networkReachabilityService = networkReachabilityService
    }
    
    var articlesPublisher: Published<[DomainArticle]>.Publisher {
        $articles
    }

    var errorMessagePublisher: Published<String?>.Publisher {
        $errorMessage
    }
    
    func loadArticles(section: String, period: Int) {
        guard networkReachabilityService.isReachable else {
                    errorMessage = "No internet connection."
                    return
                }
        guard let endpoint = NYTimesEndpoint.mostViewedEndpoint(section: section, period: period) else {
            errorMessage = "Invalid endpoint"
            return
        }
        fetchArticles(from: endpoint)
    }
    
    private func fetchArticles(from endpoint: NYTimesEndpoint) {
        fetchMostPopularArticlesUseCase.loadArticles(endpoint: endpoint) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        self.errorMessage = "An error occurred: \(error.localizedDescription)"
    }
    
    func getNumberOfRowsInSections() -> Int {
        articles.count
    }
    
    func getArticle(index: Int) -> DomainArticle? {
        guard index >= 0 && index < articles.count else { return nil }
        return articles[index]
    }
}
