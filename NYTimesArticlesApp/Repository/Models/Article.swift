//
//  Article.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//
import Foundation
struct Article: Codable {
    let url: String
    let id: Int
    let source: String?
    let publishedDate: String
    let section: String?
    let author: String?
    let type: String?
    let title: String
    let abstract: String?
    let media: [Media]?

    enum CodingKeys: String, CodingKey {
        case url
        case id
        case source
        case publishedDate = "published_date"
        case section
        case author = "byline"
        case type
        case title
        case abstract
        case media
    }

}

extension Article {
    func toDomainModel() -> DomainArticle {
            return DomainArticle(
                id: id,
                title: title,
                abstract: abstract ?? "",
                url: url,
                publishedDateString: publishedDate,  // Pass the date string directly
                media: media?.map { $0.toDomainModel() } ?? [],
                author: author,
                section: section,
                type: type
            )
        }
}
