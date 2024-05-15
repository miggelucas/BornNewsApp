//
//  Article.swift
//  BornNews App
//
//  Created by Lucas Migge on 14/05/24.
//

import Foundation

protocol Article {
    var sourceName: String { get }
    var authorName: String { get }
    var title: String { get }
    var summary: String { get }
    var url: String { get }
    var urlToImage: String? { get }
    var imageData: Data? { get set }
    var publishedAt: String { get }
    var content: String? { get }

    var publishedDate: Date? { get }
    
}
