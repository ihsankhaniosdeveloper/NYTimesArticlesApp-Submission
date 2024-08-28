//
//  DomainMediaMetadata.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation
struct DomainMediaMetadata {
    let url: String
    let format: String
    let width: Int
    let height: Int
    
    func size() -> Int {
        return width * height
    }
}
