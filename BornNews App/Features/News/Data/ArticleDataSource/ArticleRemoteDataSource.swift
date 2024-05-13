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
    
    enum EndPointsAPI {
        case headlines
        case everything
        
        var value: String {
            switch self {
            case .everything:
                return "https://newsapi.org/v2/everything"
                
            case .headlines:
                return "https://newsapi.org/v2/top-headlines"
            }
        }
    }
    
    func fetchHeadlineArticles() async throws -> [Article] {
        var baseComponent = URLComponents(string: EndPointsAPI.headlines.value)
        

        baseComponent?.queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "apiKey", value: API_KEY)
        ]
        
        guard let url = baseComponent?.url else {
            throw RemoteDataSourceError.badRequest
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await networkSession.data(for: request, delegate: nil)
            
            let fetchedData = try JSONDecoder().decode(ArticleResponse.self, from: data)
            
            guard fetchedData.status == "ok" else { throw RemoteDataSourceError.serverError}
            
            return fetchedData.articles
            
        } catch {
            throw RemoteDataSourceError.failedToFetch
        }
    }
}
