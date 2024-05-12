//
//  NetworkSession.swift
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
