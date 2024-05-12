//
//  Article.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

struct Article: Codable {
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}
