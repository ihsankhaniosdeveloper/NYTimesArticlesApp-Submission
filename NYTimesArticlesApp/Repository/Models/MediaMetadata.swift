//
//  MediaMetadata.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation
struct MediaMetadata: Codable {
    let url: String?
    let format: String?
    let height: Int?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case url
        case format
        case height
        case width
    }

}

extension MediaMetadata {
    func toDomainModel() -> DomainMediaMetadata {
        return DomainMediaMetadata(
            url: url ?? "",
            format: format ?? "",
            width: width ?? 0,
            height: height ?? 0
        )
    }
}
