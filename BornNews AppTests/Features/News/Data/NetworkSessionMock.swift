//
//  NetworkSessionMock.swift
//  BornNews AppTests
//
//  Created by Lucas Migge on 14/05/24.
//


import Foundation
@testable import BornNews_App

class NetworkSessionMock: NetworkSession {
    
    enum NetworkSessionError: Error {
        case fail
    }
    
    var shouldThrowError: Bool = false
    
    var response: URLResponse?
    
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)? = nil) async throws -> (Data, URLResponse) {
        if !shouldThrowError {
            return (fetchHeadLineDataSample, URLResponse())
        } else {
            throw NetworkSessionError.fail
        }
    }
}

extension NetworkSessionMock {
    var fetchHeadLineDataSample: Data {
        guard let jsonURL = Bundle(for: type(of: self)).url(forResource: "ArticleResponseSample", withExtension: "json") else {
            fatalError("file JSON not fount.")
        }

        do {
            let jsonData = try Data(contentsOf: jsonURL)
            return jsonData
        } catch {
            fatalError("failed to read JSON: \(error.localizedDescription)")
        }
    }
}
