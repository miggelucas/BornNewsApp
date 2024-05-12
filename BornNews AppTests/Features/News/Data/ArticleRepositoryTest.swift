//
//  ArticleRepositoryTest.swift
//  BornNews AppTests
//
//  Created by Lucas Migge on 11/05/24.
//

import XCTest
@testable import BornNews_App

class RemoteArticleDataSourceMock: ArticleRemoteDataSourceProtocol {
    var shouldFetchHeadlineArticlesBeSuccessful: Bool = true
    var didCallFetchHeadlineArticles: Bool = false
    
    func fetchHeadlineArticles() async throws -> [Article] {
        
        didCallFetchHeadlineArticles = true

        if shouldFetchHeadlineArticlesBeSuccessful {
            return []
        } else {
            throw RemoteDataSourceError.failedToFetch
        }
    }
}


final class ArticleRepositoryTest: XCTestCase {
    
    var repository: ArticleRepository!
    var articleDataSourceMock: RemoteArticleDataSourceMock!
    
    override func setUpWithError() throws {
        articleDataSourceMock = RemoteArticleDataSourceMock()
        repository = ArticleRepository(remoteDataSource: articleDataSourceMock)
    }
    
    override func tearDownWithError() throws {
        articleDataSourceMock = nil
        repository = nil
    }
    
    
    func testGetHeadlineArticlesShouldCallFetchFromDatasource() async {
        articleDataSourceMock.didCallFetchHeadlineArticles = false
        
        _ = await repository.getHeadlineArticles()
        
        XCTAssertTrue(articleDataSourceMock.didCallFetchHeadlineArticles)
        
    }
    
    func testGetHeadlineArticlesShouldReturnArticlesArrayIfFetchSuccessful() async {
        articleDataSourceMock.shouldFetchHeadlineArticlesBeSuccessful = true
        
        let result = await repository.getHeadlineArticles()
        
        XCTAssertNoThrow(try result.get())
    }
    
    func testGetHeadlineArticlesShouldReturnErrorResultIfFetchFails() async {
        articleDataSourceMock.shouldFetchHeadlineArticlesBeSuccessful = false
        
        let result = await repository.getHeadlineArticles()
        
        XCTAssertThrowsError(try result.get())
    }
}
