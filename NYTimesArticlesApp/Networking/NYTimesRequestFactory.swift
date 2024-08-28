//
//  NYTimesRequestFactory.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation

class NYTimesRequestFactory {

    static func baseURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nytimes.com"
        return components
    }

    static func baseURLRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
