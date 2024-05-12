//
//  ArticleRemoteDataSourceTest.swift
//  BornNews AppTests
//
//  Created by Lucas Migge on 11/05/24.
//

import XCTest
@testable import BornNews_App

class NetworkSessionMock: NetworkSession {
    
    let sampleArticleData = """
    {
        "author": "John Doe",
        "title": "Sample Article Title",
        "description": "This is a sample article description.",
        "url": "https://www.example.com/sample-article",
        "urlToImage": "https://www.example.com/sample-image.jpg",
        "publishedAt": "2024-05-12T10:00:00Z",
        "content": "This is a sample article content."
    }
    """.data(using: .utf8)!
    
    enum NetworkSessionError: Error {
        case fail
    }
    
    var shouldThrowError: Bool = false
    
    var data: Data?
    var response: URLResponse?
    
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)? = nil) async throws -> (Data, URLResponse) {
        if !shouldThrowError {
            return (Data(), URLResponse())
        } else {
            throw NetworkSessionError.fail
        }
    }
}

final class ArticleRemoteDataSourceTests: XCTestCase {
    
    var dataSource: ArticleRemoteDataSource!
    var networkSessionMock: NetworkSessionMock!
    
    
    override func setUp() {
        super.setUp()
        networkSessionMock = NetworkSessionMock()
        dataSource = ArticleRemoteDataSource(networkSession: networkSessionMock)
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }
    
//    func testFetchHeadlineArticles() {
//        // Given
//        let expectation = XCTestExpectation(description: "Fetch headline articles")
//        
//        
//        
//        
//        // Wait for expectation
//        wait(for: [expectation], timeout: 5.0)
//    }
}
