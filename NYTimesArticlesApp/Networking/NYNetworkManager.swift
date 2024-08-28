//
//  NYNetworkManager.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation
// MARK: - Protocol for Network Manager
import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case noData
}
// MARK: - NetworkManager Implementation
class NYNetworkManager: ArticlesDataSourceProtocol {
    private let requestExecutor: RequestExecutor
        init(requestExecutor: RequestExecutor = RequestExecutor()) {
            self.requestExecutor = requestExecutor
        }
        func fetchArticles(from endpoint: NYTimesEndpoint, completion: @escaping (Result<Data, Error>) -> Void) {
            guard let request = try? URLRequest.make(
                endpoint: endpoint.path,
                headers: nil,
                queries: endpoint.queryItems,
                method: endpoint.method,
                version: nil,
                params: nil
            ) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            requestExecutor.executeRequest(with: request, completion: completion)
        }
    
}

