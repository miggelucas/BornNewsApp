//
//  ArticleRepository.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

class ArticleRepository: ArticleRepositoble {
    
    let remoteDataSource: ArticleDataSourceble
    
    init(remoteDataSource: ArticleDataSourceble = ArticleDataSource() ) {
        self.remoteDataSource = remoteDataSource
    }
    
    
    func getHeadlineArticles() async -> Result<[Article], any Error> {
        do {
            let result = try await remoteDataSource.fetchHeadlineArticles()
            return .success(result)
        } catch {
            return .failure(RemoteDataSourceError.failedToFetch)
        }
    }
}
