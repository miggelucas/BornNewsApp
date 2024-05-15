//
//  ArticleDataSourceble.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

protocol ArticleRemoteDataSourceProtocol {
    
    func fetchHeadlineArticles(country: CountryOption,
                               category: CategoryOption,
                               page: Int) async throws -> [ArticleModel]
    
    func fetchSearchArticles(query: QueryOption, language: LanguageOption, page: Int) async throws -> [ArticleModel]
}
