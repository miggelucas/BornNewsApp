//
//  Date.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import Foundation

extension Date {
    
    // ArticleTableViewCell
    var shortDateDescription: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: self)
    }
    
    // ArticleDetailViewController
    var DateDescription: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy - HH:mm'hs'"

        return  dateFormatter.string(from: self)
    }
}
