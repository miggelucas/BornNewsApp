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
    
    func getHeadlineArticles(country: CountryOption = .unitedStates,
                             category: CategoryOption = .general,
                             page: Int) async -> Result<[Article], RemoteDataSourceError> {
        do {
            let result = try await remoteDataSource.fetchHeadlineArticles(country: country,
                                                                          category: category,
                                                                          page: page)
            return .success(result)
        } catch let error as RemoteDataSourceError {
            return .failure(error)
        } catch {
            return .failure(.failedToFetch)
        }
    }
}
