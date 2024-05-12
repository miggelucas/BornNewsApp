//
//  ArticleRepositoble.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

protocol ArticleRepositoryProtocol {
    func getHeadlineArticles() async -> Result<[Article], Error>
    
    func getHeadlineArticles(handler: @escaping (Result<[Article], RemoteDataSourceError>) -> Void)
    
}


