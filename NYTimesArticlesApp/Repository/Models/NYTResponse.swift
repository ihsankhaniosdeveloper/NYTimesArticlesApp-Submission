//
//  NYTResponse.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation

struct NYTResponse: Decodable {
    let status: String?
    let copyright: String?
    let numResults: Int?
    let results: [Article]

    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
}
