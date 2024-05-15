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
    
    let API_KEY: String = "f83edef801734100bac6b68e410e4364"
    
    func createHeadlineUrlRequest(
        country: CountryOption = .unitedStates,
        category: CategoryOption = .general,
        page: Int) throws -> URLRequest  {
            
            guard page > 0 else { throw RemoteDataSourceError.badRequest  }
            
            var baseComponent = URLComponents(string: EndPointsOption.headlines.code)
            
            baseComponent?.queryItems = [
                URLQueryItem(name: ApiKey.key, value: ApiKey.value),
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

}
