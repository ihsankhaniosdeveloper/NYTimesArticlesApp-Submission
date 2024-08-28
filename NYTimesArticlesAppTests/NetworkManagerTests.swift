//
//  NetworkManagerTests.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import XCTest
@testable import NYTimesArticlesApp
class NetworkManagerTests: XCTestCase {
    
    func testSuccessfulAPICall() {
        // Arrange
        let expectation = self.expectation(description: "Mocked API call completes successfully")
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.shouldReturnError = false
        mockNetworkManager.mockJSONData = """
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
        
        let endpoint = NYTimesEndpoint.mostViewed(section: "all-sections", period: 7, apiKey: "mock_api_key")
        
        // Act
        mockNetworkManager.fetchArticles(from: endpoint) { result in
            // Assert
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                
                do {
                    let response = try JSONDecoder().decode(NYTResponse.self, from: data)
                    XCTAssertEqual(response.results.count, 2)
                    XCTAssertEqual(response.results.first?.title, "Article 1")
                    expectation.fulfill()
                } catch {
                    XCTFail("faile: \(error)")
                }
                
            case .failure(let error):
                XCTFail("expected successfult but got error  \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func testAPICallFailure() {
        // Arrange
        let expectation = self.expectation(description: "api fails")
        
        //mock network
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager.shouldReturnError = true  //error simulation
        
        let endpoint = NYTimesEndpoint.mostViewed(section: "all-sections", period: 7, apiKey: "mock_api_key")
        
        // Act
        mockNetworkManager.fetchArticles(from: endpoint) { result in
            // Assert
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success instead")
            case .failure(let error):
                let nsError = error as NSError
                XCTAssertEqual(nsError.domain, "MockErrorDomain")
                XCTAssertEqual(nsError.code, 500)
                XCTAssertEqual(nsError.localizedDescription, "Mock error")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    
    
}
