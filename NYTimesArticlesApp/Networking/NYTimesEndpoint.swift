//
//  NYTimesEndpoint.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias HTTPParameters = [String: Any]

public enum HTTPMethod: String {
    case GET
}

public enum NYTimesEndpoint {
    case mostViewed(section: String, period: Int, apiKey: String)
    var basePath: String {
        return "/svc/mostpopular/v2"
    }
    
    var path: String {
        switch self {
        case .mostViewed(let section, let period, _):
            return "\(basePath)/mostviewed/\(section)/\(period).json"
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
    var queryItems: [NYTimesQueryItem]? {
        switch self {
        case .mostViewed(_, _, let apiKey):
            return [
                NYTimesQueryItem(key: "api-key", value: apiKey)
            ]
        }
        
    }
    
    // Factory method to create an endpoint, handling API key retrieval
    static func mostViewedEndpoint(section: String, period: Int) -> NYTimesEndpoint? {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            print("API Key not found!")
            return nil
        }
        return .mostViewed(section: section, period: period, apiKey: apiKey)
    }
    
    
}

extension NYTimesEndpoint {
    
    func urlRequest(headers: HTTPHeaders? = nil) -> URLRequest? {
        return try? URLRequest.make(
            endpoint: self.path,
            headers: headers,                       // Pass any custom headers here
            queries: self.queryItems,               // Add the query items from the endpoint
            method: self.method,                    // HTTP method associated with the endpoint
            version: nil,                           // You can add API versioning if needed
            params: nil                             // No parameters for GET requests, can be used for POST/PUT
        )
    }
}

extension URLRequest {
    mutating func addHeaders(_ headers: HTTPHeaders?) {
        headers?.forEach { key, value in
            self.setValue(value, forHTTPHeaderField: key)
        }
    }
}
extension URLRequest {

    static func make(endpoint: String, headers: HTTPHeaders? = nil, queries: [NYTimesQueryItem]? = nil, method: HTTPMethod = .GET, version: Int? = nil, params: HTTPParameters? = nil) throws -> URLRequest {

        var urlComponents = NYTimesRequestFactory.baseURLComponents()
        
        // Validate the endpoint
            guard !endpoint.isEmpty else {
                throw RequestError.invalidURL
            }
        
        urlComponents.path.append(endpoint)

        if let queryArray = queries, !queryArray.isEmpty {
            urlComponents.queryItems = queryArray.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = urlComponents.url else {
            throw RequestError.invalidURL
        }

        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let parameters = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                throw RequestError.invalidParameters
            }
        }
        
        request.addHeaders(headers)

        return request
    }
}


struct NYTimesQueryItem {
    let key: String
    let value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

enum RequestError: Error {
    case invalidURL
    case invalidParameters
}
