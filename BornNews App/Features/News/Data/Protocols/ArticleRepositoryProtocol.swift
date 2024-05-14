//
//  ArticleRepositoble.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

protocol ArticleRepositoryProtocol {
    
    func getHeadlineArticles(country: CountryOption,
                             category: CategoryOption,
                             page: Int) async -> Result<[Article], RemoteDataSourceError>
    
}


