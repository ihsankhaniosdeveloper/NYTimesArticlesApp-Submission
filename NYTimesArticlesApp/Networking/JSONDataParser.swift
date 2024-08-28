//
//  JSONDataParser.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 28/08/2024.
//

import Foundation
protocol DataParser {
    associatedtype Output
    func parse(data: Data) throws -> Output
}
class JSONDataParser<T: Decodable>: DataParser {
    typealias Output = T

    func parse(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
