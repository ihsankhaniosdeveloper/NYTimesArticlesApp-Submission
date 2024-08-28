//
//  ArticlesCoordinatorTests.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 28/08/2024.
//

import XCTest
@testable import NYTimesArticlesApp

class ArticlesCoordinatorTests: XCTestCase {
    
    var navigationController: UINavigationController!
    var coordinator: ArticlesCoordinator!
    var mockNetworkReachabilityService: MockNetworkReachabilityService!

    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        mockNetworkReachabilityService = MockNetworkReachabilityService()

        coordinator = ArticlesCoordinator(navigationController: navigationController, networkReachabilityService: mockNetworkReachabilityService)
    }
    
    override func tearDown() {
        coordinator = nil
        navigationController = nil
        super.tearDown()
    }
    
    func testStartSetsRootViewController() {
        coordinator.start()
        // Assert
        XCTAssertTrue(navigationController.viewControllers.first is ArticlesViewController)
        
        let articlesViewController = navigationController.viewControllers.first as? ArticlesViewController
        XCTAssertNotNil(articlesViewController?.viewModel)
        XCTAssertNotNil(articlesViewController?.coordinator)
    }
    
    
    func testShowArticleDetailsPushesDetailsViewController() {
        coordinator.start()
        let article = DomainArticle(id: 0, title: "", abstract: "", url: "", publishedDateString: "", media: [], author: "", section: "", type: "")
        
        let expectation = XCTestExpectation(description: "Wait for ArticleDetailViewController to be pushed")
        
        DispatchQueue.main.async {
            self.coordinator.showArticleDetails(for: article)
            expectation.fulfill()
        }
        
        // Wait
        wait(for: [expectation], timeout: 1.0)
        
        // Assert
        XCTAssertTrue(self.navigationController.viewControllers.last is ArticleDetailViewController)
        
        let detailsViewController = self.navigationController.viewControllers.last as? ArticleDetailViewController
        XCTAssertNotNil(detailsViewController?.viewModel)
        XCTAssertNotNil(detailsViewController?.coordinator)
        XCTAssertEqual(detailsViewController?.viewModel.article, article)
    }
    
    func testNavigationFlow() {
        coordinator.start()
        let article = DomainArticle(id: 0, title: "", abstract: "", url: "", publishedDateString: "", media: [], author: "", section: "", type: "")
        let expectation = XCTestExpectation(description: "Wait for navigation to complete")
        DispatchQueue.main.async {
            self.coordinator.showArticleDetails(for: article)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        // Assert
        XCTAssertEqual(self.navigationController.viewControllers.count, 2)
        XCTAssertTrue(self.navigationController.viewControllers[0] is ArticlesViewController)
        XCTAssertTrue(self.navigationController.viewControllers[1] is ArticleDetailViewController)
    }
    
    
    
    
}
