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
    
    func getHeadlineArticles(handler: @escaping (Result<[Article], RemoteDataSourceError>) -> Void) {
        Task {
            do {
                let result = try await remoteDataSource.fetchHeadlineArticles()
                print(result)
                handler(.success(result))
            } catch {
                handler(.failure(RemoteDataSourceError.failedToFetch))
            }
        }
    }
    
    func getHeadlineArticles() async -> Result<[Article], any Error> {
        do {
//            let result = try await remoteDataSource.fetchHeadlineArticles()
            return .success(Article.getSampleArticles())
        } catch {
            return .failure(RemoteDataSourceError.failedToFetch)
        }
    }
}
