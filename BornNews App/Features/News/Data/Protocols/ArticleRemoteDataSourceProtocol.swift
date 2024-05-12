//
//  ArticleDataSourceble.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

protocol ArticleRemoteDataSourceProtocol {
    func fetchHeadlineArticles() async throws -> [Article]
}
