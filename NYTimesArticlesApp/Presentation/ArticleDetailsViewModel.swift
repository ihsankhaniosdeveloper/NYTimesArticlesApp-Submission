//
//  DetailsViewModel.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import Foundation
protocol ArticleDetailsViewModelProtocol {
    var article: DomainArticle { get }
    var title: String { get }
    var author: String { get }
    var coverPic: String? { get }
    var description: String { get }
    var type: String { get }
    var publishedDate: String { get }
}
class ArticleDetailsViewModel: ArticleDetailsViewModelProtocol {
    var article: DomainArticle

    init(article: DomainArticle) {
        self.article = article
    }

    var title: String {
        return article.title
    }
    var author: String {
        return article.author ?? ""
    }
    var coverPic: String? {
        return  article.coverPic
    }
    var description: String {
        return article.abstract
    }
    var type: String {
        return article.type ?? ""
    }
    var publishedDate: String {
        return article.formattedDate
    }
}
