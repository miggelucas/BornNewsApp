//
//  ArticleDataSourceble.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

protocol ArticleDataSourceble {
    func fetchHeadlineArticles() async throws -> [Article]
}
