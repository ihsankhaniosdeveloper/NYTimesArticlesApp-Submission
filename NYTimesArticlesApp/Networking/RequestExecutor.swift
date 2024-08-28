//
//  RequestExecutor.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 28/08/2024.
//

import Foundation
class RequestExecutor {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    func executeRequest(with request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}
