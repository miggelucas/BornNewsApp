//
//  ArticleDataSource.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation


class ArticleRemoteDataSource: ArticleRemoteDataSourceProtocol {
    
    let networkSession: NetworkSession
    
    init(networkSession: NetworkSession = URLSession.shared) {
        self.networkSession = networkSession
    }
    
    let apiKey: ApiKey = .personal
    
    func createHeadlineUrlRequest(
        country: CountryOption = .unitedStates,
        category: CategoryOption = .general,
        page: Int) throws -> URLRequest  {
            
            guard page > 0 else { throw RemoteDataSourceError.badRequest  }
            
            var baseComponent = URLComponents(string: EndPointsOption.headlines.code)
            
            baseComponent?.queryItems = [
                URLQueryItem(name: apiKey.key, value: apiKey.value),
                URLQueryItem(name: country.key, value: country.value),
                URLQueryItem(name: category.key, value: category.value),
                URLQueryItem(name: "page", value: String(page)),
            ]
            
            guard let url = baseComponent?.url else { throw RemoteDataSourceError.badRequest }
            
            return URLRequest(url: url)
    }
    
    func fetchHeadlineArticles(country: CountryOption = .unitedStates,
                               category: CategoryOption = .general,
                               page: Int) async throws -> [ArticleModel] {
        
        let request = try createHeadlineUrlRequest(country: country, category: category, page: page)
        
        do {
            let (data, _) = try await networkSession.data(for: request, delegate: nil)
            
            let fetchedData = try JSONDecoder().decode(ArticleResponse.self, from: data)
            
            
            guard fetchedData.status == "ok" else { throw RemoteDataSourceError.serverError }
            
            guard !fetchedData.articles.isEmpty else { throw RemoteDataSourceError.noMoreData }
            return fetchedData.articles
            
        } catch _ {
            throw RemoteDataSourceError.failedToFetch
        }
    }
    
    func createSearchUrlRequest(query: QueryOption, language: LanguageOption = .english, page: Int) throws -> URLRequest {
        
        guard page > 0 else { throw RemoteDataSourceError.badRequest  }
        guard !query.value.isEmpty else { throw RemoteDataSourceError.badRequest }
        
        var baseComponent = URLComponents(string: EndPointsOption.everything.code)
        
//        let options: [ApiParamOption] = [query, language, page, apiKey]
//        baseComponent?.queryItems = options.map { option in
//            return URLQueryItem(name: option.key, value: option.value)
//        }
        
        baseComponent?.queryItems = [
            URLQueryItem(name: apiKey.key, value: apiKey.value),
            URLQueryItem(name: language.key, value: language.value),
            URLQueryItem(name: query.key, value: query.value),
            URLQueryItem(name: "page", value: String(page)),
        ]
        
        guard let url = baseComponent?.url else { throw RemoteDataSourceError.badRequest }
        
        return URLRequest(url: url)
    }

    func fetchSearchArticles(query: QueryOption, language: LanguageOption = .english, page: Int) async throws -> [ArticleModel] {
        
        let request = try createSearchUrlRequest(query: query, language: language, page: page)
        
        do {
            let (data, _) = try await networkSession.data(for: request, delegate: nil)
            
            let fetchedData = try JSONDecoder().decode(ArticleResponse.self, from: data)
            
            
            guard fetchedData.status == "ok" else { throw RemoteDataSourceError.serverError }
            
            guard !fetchedData.articles.isEmpty else { throw RemoteDataSourceError.noMoreData }
            return fetchedData.articles
            
        } catch _ {
            throw RemoteDataSourceError.failedToFetch
        }
    }
    
}
