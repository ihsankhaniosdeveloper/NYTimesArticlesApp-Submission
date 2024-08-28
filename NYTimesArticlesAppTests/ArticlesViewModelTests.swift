//
//  ArticlesViewModelTests.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import XCTest
import Combine
@testable import NYTimesArticlesApp

class ArticlesViewModelTests: XCTestCase {
    
    var viewModel: ArticlesViewModel!
    var repository: MockArticlesRepository!
    var cancellables: Set<AnyCancellable>!
    var mockNetworkReachabilityService: MockNetworkReachabilityService!

    override func setUp() {
        super.setUp()
        repository = MockArticlesRepository()
        let useCase = FetchMostPopularArticlesUseCase(repository: repository)
        mockNetworkReachabilityService = MockNetworkReachabilityService()
        viewModel = ArticlesViewModel(fetchMostPopularArticlesUseCase: useCase, networkReachabilityService: mockNetworkReachabilityService)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        repository = nil
        mockNetworkReachabilityService = nil
        super.tearDown()
    }
    
    func testFetchArticlesWithNoInternet() {
            // Simulate no internet connection
            mockNetworkReachabilityService.isReachable = false
            
            viewModel.loadArticles(section: "all-sections", period: 7)
            
            XCTAssertEqual(viewModel.errorMessage, "No internet connection.")
            XCTAssertTrue(viewModel.articles.isEmpty)
        }
    
    func testFetchArticlesSuccess() {
        let mockUseCase = MockFetchMostPopularArticlesUseCase()
        let viewModel = ArticlesViewModel(fetchMostPopularArticlesUseCase: mockUseCase, networkReachabilityService: mockNetworkReachabilityService)
        let expectedArticles = [DomainArticle(id: 1, title: "Title1", abstract: "Abstract1", url: "URL1", publishedDateString: "2023-01-01", media: [], author: "Author1", section: "Section1", type: "Type1")]
        mockUseCase.result = .success(expectedArticles)
        viewModel.loadArticles(section: "all-sections", period: 7)
        XCTAssertEqual(viewModel.articles, expectedArticles)
    }
    
    
    func testFetchArticlesFailure() {
        let mockUseCase = MockFetchMostPopularArticlesUseCase()
        let viewModel = ArticlesViewModel(fetchMostPopularArticlesUseCase: mockUseCase, networkReachabilityService: mockNetworkReachabilityService)
        let expectedError = NSError(domain: "TestError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network Error"])
        mockUseCase.result = .failure(expectedError)
       viewModel.loadArticles(section: "all-sections", period: 7)
        
        XCTAssertEqual(viewModel.errorMessage, "An error occurred: Network Error")
        XCTAssertTrue(viewModel.articles.isEmpty)  //check empty article
    }

    }


