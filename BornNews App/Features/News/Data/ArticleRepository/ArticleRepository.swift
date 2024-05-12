//
//  ArticleRepository.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

class ArticleRepository: ArticleRepositoble {
    
    let remoteDataSource: ArticleRemoteDataSourceProtocol
    
    init(remoteDataSource: ArticleRemoteDataSourceProtocol = ArticleRemoteDataSource() ) {
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
