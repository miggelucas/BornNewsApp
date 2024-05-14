//
//  ArticleRepositoryTest.swift
//  BornNews AppTests
//
//  Created by Lucas Migge on 11/05/24.
//

import XCTest
@testable import BornNews_App

class RemoteArticleDataSourceMock: ArticleRemoteDataSourceProtocol {
    func fetchHeadlineArticles(country: BornNews_App.CountryOption, category: BornNews_App.CategoryOption, page: Int) async throws -> [Article] {
        return []
    }
    
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
    
    
    func testRemoveInvalidArticlesFiltersOnlyArticlesNamedRemoved() {
        let article1 = Article(source: Source(name: "test"),  title: "Awesome Title", url: "google.com", publishedAt: "today")
        let article2 = Article(source: Source(name: "test"),  title: "[Removed]", url: "google.com", publishedAt: "someday")
        let article3 = Article(source: Source(name: "test"),  title: "Great Article", url: "google.com", publishedAt: "12/05/99")
        
        let filteredArticles = repository.removeInvalidArticles(for: [article1, article2, article3])
        
        XCTAssertFalse(filteredArticles.contains(where: {$0.title == article2.title}))
        XCTAssertEqual(filteredArticles.count, 2)
    }
}
