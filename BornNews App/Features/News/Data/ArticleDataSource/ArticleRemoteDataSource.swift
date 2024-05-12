//
//  ArticleDataSource.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

// Protocolo para o provedor de sessão de rede
protocol NetworkSession {
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

// Implementação padrão do provedor de sessão de rede
extension URLSession: NetworkSession {}

class ArticleRemoteDataSource: ArticleRemoteDataSourceProtocol {
    
    let networkSession: NetworkSession
    
    init(networkSession: NetworkSession = URLSession.shared) {
        self.networkSession = networkSession
    }
    
    let API_KEY: String = "f83edef801734100bac6b68e410e4364f83edef801734100bac6b68e410e4364"
    
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
        var baseUrl = URLComponents(string: EndPointsAPI.headlines.value)
        
        baseUrl?.queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "apiKey", value: API_KEY)
        ]
        
        guard let url = baseUrl?.url else { throw RemoteDataSourceError.badRequest }
        
        do {
            let (data, _) = try await networkSession.data(for: URLRequest(url: url), delegate: nil)
            
            let response = try JSONDecoder().decode(ArticleResponse.self, from: data)
            
            if response.status != "ok" {
                throw RemoteDataSourceError.serverError
            } else {
                return response.articles
            }
            
        } catch {
            throw RemoteDataSourceError.failedToFetch
        }
    }
}
