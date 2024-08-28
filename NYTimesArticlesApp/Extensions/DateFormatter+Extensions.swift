//
//  DateFormatter+Extensions.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation

extension DateFormatter {
    static func with(format: String, locale: Locale = Locale(identifier: "en_US_POSIX"), timeZone: TimeZone? = TimeZone(secondsFromGMT: 0)) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter
    }
    
    static let apiDateFormatter: DateFormatter = {
        return DateFormatter.with(format: "yyyy-MM-dd")
    }()
    
    static let apiDateTimeFormatter: DateFormatter = {
        return DateFormatter.with(format: "yyyy-MM-dd HH:mm:ss")
    }()
    
    static let displayDateFormatter: DateFormatter = {
        return DateFormatter.with(format: "MMM d, yyyy", locale: Locale.current, timeZone: TimeZone.current)
    }()
}

extension Date {
    func string(format:String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return  dateFormatter.string(from: self)
    }
}
