//
//  ArticleRepository.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

class ArticleRepository: ArticleRepositoryProtocol {
    
    let remoteDataSource: ArticleRemoteDataSourceProtocol
    
    init(remoteDataSource: ArticleRemoteDataSourceProtocol = ArticleRemoteDataSource() ) {
        self.remoteDataSource = remoteDataSource
    }
    
    
    func getHeadlineArticles() async -> Result<[Article], RemoteDataSourceError> {
        do {
            let result = try await remoteDataSource.fetchHeadlineArticles()
            return .success(result)
        } catch {
            print("ERROR: Failed to Fetch from Remote Datasource")
            return .failure(RemoteDataSourceError.failedToFetch)
        }
    }
}
