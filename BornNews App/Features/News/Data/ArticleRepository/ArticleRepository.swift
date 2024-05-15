//
//  ArticleRepository.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

class ArticleRepository: ArticleRepositoryProtocol {
    
    let remoteDataSource: ArticleRemoteDataSourceProtocol
    
    init(remoteDataSource: ArticleRemoteDataSourceProtocol = ArticleRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func removeInvalidArticles(for articles: [ArticleModel]) -> [ArticleModel] {
        return articles.filter { $0.title != "[Removed]" }
    }
    
    func fetchHeadlineArticles(country: CountryOption, category: CategoryOption, page: Int) async throws -> [ArticleModel] {
        return try await remoteDataSource.fetchHeadlineArticles(country: country, category: category, page: page)
    }
    
    func getHeadlineArticles(for category: CategoryOption, country: CountryOption = .unitedStates, page: Int) async -> Result<[Article], RemoteDataSourceError> {
        do {
            let articles = try await fetchHeadlineArticles(country: country, category: category, page: page)
            let validArticles = removeInvalidArticles(for: articles)
            return .success(validArticles)
        } catch let error as RemoteDataSourceError {
            return .failure(error)
        } catch {
            return .failure(.failedToFetch)
        }
    }
    
    func getHeadlineGeneralArticles(country: CountryOption = .unitedStates, page: Int) async -> Result<[Article], RemoteDataSourceError> {
        return await getHeadlineArticles(for: .general, country: country, page: page)
    }
    
    func getHeadlineBusinessArticles(country: CountryOption = .unitedStates, page: Int) async -> Result<[Article], RemoteDataSourceError> {
        return await getHeadlineArticles(for: .business, country: country, page: page)
    }
    
    func getHeadlineEntertainmentArticles(country: CountryOption = .unitedStates, page: Int) async -> Result<[Article], RemoteDataSourceError> {
        return await getHeadlineArticles(for: .entertainment, country: country, page: page)
    }
    
    func getHeadlineHealthArticles(country: CountryOption = .unitedStates, page: Int) async -> Result<[Article], RemoteDataSourceError> {
        return await getHeadlineArticles(for: .health, country: country, page: page)
    }
    
    func getHeadlineScienceArticles(country: CountryOption = .unitedStates, page: Int) async -> Result<[Article], RemoteDataSourceError> {
        return await getHeadlineArticles(for: .science, country: country, page: page)
    }
    
    func getHeadlineSportsArticles(country: CountryOption = .unitedStates, page: Int) async -> Result<[Article], RemoteDataSourceError> {
        return await getHeadlineArticles(for: .sports, country: country, page: page)
    }
    
    func getHeadlineTechnologyArticles(country: CountryOption = .unitedStates, page: Int) async -> Result<[Article], RemoteDataSourceError> {
        return await getHeadlineArticles(for: .technology, country: country, page: page)
    }
}
