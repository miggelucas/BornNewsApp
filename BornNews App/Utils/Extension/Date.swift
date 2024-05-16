//
//  Date.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import Foundation

extension Date {
    
    // ArticleTableViewCell
    func shortDateDescription(locale: Locale = .current) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = .short
        
        return formatter.string(from: self)
    }
    
    // ArticleDetailViewController
    func DateDescription(locale: Locale = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateStyle = .medium

        return  dateFormatter.string(from: self)
    }
}
