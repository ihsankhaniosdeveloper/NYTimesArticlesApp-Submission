//
//  URLRequestExtensionTests.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import XCTest
@testable import NYTimesArticlesApp
class URLRequestExtensionTests: XCTestCase {
    
    func testMakeURLRequest() {
        let endpoint = "/test/endpoint"
        let queries = [NYTimesQueryItem(key: "key", value: "value")]
        let method = HTTPMethod.GET
        let headers: HTTPHeaders = ["Authorization": "Bearer token"]
        
        let request = try? URLRequest.make(endpoint: endpoint, headers: headers, queries: queries, method: method)
        //Assert
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.url?.path, endpoint)
        XCTAssertEqual(request?.httpMethod, method.rawValue)
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Authorization"), "Bearer token")
        XCTAssertTrue(request?.url?.query?.contains("key=value") ?? false)
    }
    
    func testMakeURLRequestInvalidURL() {
        
        let endpoint = ""
        let queries: [NYTimesQueryItem]? = nil
        let method = HTTPMethod.GET
        //Assert
        XCTAssertThrowsError(try URLRequest.make(endpoint: endpoint, queries: queries, method: method)){ error in
            XCTAssertEqual(error as? RequestError, RequestError.invalidURL)
            
        }
    }
}
