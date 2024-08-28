//
//  MockLocalDataSource.swift
//  NYTimesArticlesAppTests
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import Foundation
@testable import NYTimesArticlesApp
class MockLocalDataSource: ArticlesDataSourceProtocol {
    var shouldReturnData = true
    var mockData: Data?
    
    func fetchArticles(from endpoint: NYTimesEndpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        if shouldReturnData, let data = mockData {
            completion(.success(data))
        } else {
            completion(.failure(NSError(domain: "MockLocalDataSourceError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No data found in local database"])))
        }
    }
}
