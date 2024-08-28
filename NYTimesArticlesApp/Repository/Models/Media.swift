//
//  Media.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation
struct Media: Codable {
    let type: String?
    let caption: String?
    let copyright: String?
    let mediaMetadata: [MediaMetadata]?

    enum CodingKeys: String, CodingKey {
        case type
        case caption
        case copyright
        case mediaMetadata = "media-metadata"
    }

}

extension Media {
    func toDomainModel() -> DomainMedia {
        return DomainMedia(
            type: type ?? "",
            caption: caption ?? "",
            mediaMetadata: mediaMetadata?.map { $0.toDomainModel() } ?? []
        )
    }
}
