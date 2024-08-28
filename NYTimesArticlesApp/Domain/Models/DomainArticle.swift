//
//  DomainArticle.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation
struct DomainArticle: Equatable {
    
    static func == (lhs: DomainArticle, rhs: DomainArticle) -> Bool {
            return lhs.id == rhs.id &&
                   lhs.title == rhs.title &&
                   lhs.abstract == rhs.abstract &&
                   lhs.url == rhs.url &&
                   lhs.publishedDateString == rhs.publishedDateString &&
                   lhs.author == rhs.author &&
                   lhs.section == rhs.section &&
                   lhs.type == rhs.type
        }
    
    let id: Int
    let title: String
    let abstract: String
    let url: String
    let publishedDateString: String
    let media: [DomainMedia]
    
    let author: String?
    let section: String?
    let type: String?
    
    private var _thumbnail: String?
    var thumbnail: String? {
        if let thumb = _thumbnail {
            return thumb
        } else if let mediaMeta = media.first?.mediaMetadata {
            guard !mediaMeta.isEmpty else { return nil }
            return mediaMeta.first(where: { $0.format == "Standard Thumbnail"})?.url ?? mediaMeta[0].url
        }
        return nil
    }
    
    private var _coverPic: String?
    var coverPic: String? {
        if let covPic = _coverPic {
            return covPic
        } else if let mediaMeta = media.first?.mediaMetadata {
            guard !mediaMeta.isEmpty else { return nil }
            return mediaMeta.max(by: { $0.size() < $1.size()})?.url ?? mediaMeta[0].url
        }
        return nil
    }
    
    
        
    // Computed property to lazily parse the date without mutating
       var date: Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"  // Default format
           return dateFormatter.date(from: publishedDateString)  // Parse and return
       }

       // Computed property to return the formatted date string
       var formattedDate: String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"  // Customize this format as needed
           
           if let date = date {
               return dateFormatter.string(from: date)
           } else {
               return "Invalid Date"
           }
       }
    
   
        // Initializer
        init(id: Int, title: String, abstract: String, url: String, publishedDateString: String, media: [DomainMedia], author: String?, section: String?, type: String?) {
            self.id = id
            self.title = title
            self.abstract = abstract
            self.url = url
            self.publishedDateString = publishedDateString  // Store the date string
            self.media = media
            self.author = author
            self.section = section
            self.type = type
            // Private properties are initialized within the struct and not exposed.
            self._thumbnail = nil
            self._coverPic = nil
        }
        
     
    
   
      
}
