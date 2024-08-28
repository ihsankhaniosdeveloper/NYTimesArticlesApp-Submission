//
//  ArticleRepositoryTests.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import XCTest
@testable import NYTimesArticlesApp
class ArticleRepositoryTests: XCTestCase {

    func testFetchArticlesFromNetworkSuccess() {
        let expectation = self.expectation(description: "successful data retrieval from network")
        let mockNetworkManager = MockNetworkManager()
        let repository = ArticlesRepository(networkDataSource: mockNetworkManager)
        let mockData = """
            {
                "results": [
                    {
                        "uri": "nyt://article/1",
                        "url": "https://example.com/article1",
                        "id": 1,
                        "title": "Article 1",
                        "author": "John Doe",
                        "published_date": "2024-08-26"
                    },
                    {
                        "uri": "nyt://article/2",
                        "url": "https://example.com/article2",
                        "id": 2,
                        "title": "Article 2",
                        "author": "Jane Doe",
                        "published_date": "2024-08-25"
                    }
                ]
            }
            """.data(using: .utf8)
        mockNetworkManager.mockJSONData = mockData
        
        //Act
        repository.getMostPopularArticles(endpoint: .mostViewed(section: "all-sections", period: 7, apiKey: "mock_api_key")) { result in
            //Assert
            switch result {
            case .success(let articles):
                XCTAssertNotNil(articles, "Expected non-nil articles")
                XCTAssertEqual(articles.count, 2, "Expected article count does not match")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Got (\(error)")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchArticlesFromLocalDatabase() {
        let expectation = self.expectation(description: "Data should be fetched from local database")
        
        let mockLocalDataSource = MockLocalDataSource()
        let mockNetworkManager = MockNetworkManager()
        
        // first check the local data source, then check network..
        let repository = ArticlesRepository(networkDataSource: mockNetworkManager, localDataSource: mockLocalDataSource)
        
        // mock data
        let mockLocalData = """
            {
             "status": "OK",
                "results": [
                    {
                        "uri": "nyt://article/1",
                        "url": "https://example.com/article1",
                        "id": 1,
                        "title": "Article 1",
                        "author": "John Doe",
                        "published_date": "2024-08-26"
                    },
                    {
                        "uri": "nyt://article/2",
                        "url": "https://example.com/article2",
                        "id": 2,
                        "title": "Article 2",
                        "author": "Jane Doe",
                        "published_date": "2024-08-25"
                    }
                ]
            }
            """.data(using: .utf8)
        mockLocalDataSource.mockData = mockLocalData
        
        repository.getMostPopularArticles(endpoint: .mostViewed(section: "all-sections", period: 7, apiKey: "mock_api_key")) { result in
            
            // Assert
            switch result {
            case .success(let articles):
                XCTAssertNotNil(articles, "Expected non-nil articles from local database")
                XCTAssertEqual(articles.count, 2, "Expected article count from local database does not match")
                
                //ensure network manager shouldn't get called 
                XCTAssertFalse(mockNetworkManager.didFetchFromNetwork, "Network manager should not have been called")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected successful response from local database, got \(error) instead")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }


}
