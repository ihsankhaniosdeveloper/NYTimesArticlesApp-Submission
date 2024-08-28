//
//  MockNetworkManager.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import Foundation
@testable import NYTimesArticlesApp

class MockNetworkManager: ArticlesDataSourceProtocol {
    
    var didFetchFromNetwork = false
    var shouldReturnError = false
    var mockJSONData: Data?

    func fetchArticles(from endpoint: NYTimesEndpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        didFetchFromNetwork = true

        if shouldReturnError {
            let error = NSError(domain: "MockErrorDomain", code: 500, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
            completion(.failure(error))
        } else if let data = mockJSONData {
            completion(.success(data))
        } else {
            let error = NSError(domain: "MockErrorDomain", code: 404, userInfo: [NSLocalizedDescriptionKey: "No data found"])
            completion(.failure(error))
        }
    }
}
