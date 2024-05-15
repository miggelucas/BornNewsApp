//
//  ArticleResponse.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

struct ArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleModel]
}
