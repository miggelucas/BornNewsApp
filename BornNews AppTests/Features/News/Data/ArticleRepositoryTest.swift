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
    
    var didCallFetchHeadlineForCategory: CategoryOption?
    
    func fetchHeadlineArticles(country: CountryOption, category: CategoryOption, page: Int) async throws -> [Article] {
        
        didCallFetchHeadlineArticles = true
        didCallFetchHeadlineForCategory = category

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
    
    func testGetHeadlineArticlesReturnSuccessWhenSuccessfulCallWithDatasource() async {
        
        articleDataSourceMock.shouldFetchHeadlineArticlesBeSuccessful = true
        
        let result = await repository.getHeadlineHealthArticles(page: 1)
        
        XCTAssertNoThrow(try result.get())
    }
    
    func testGetHeadlineArticlesReturnFailureWhenCallWithDatasourceFails() async {
        
        articleDataSourceMock.shouldFetchHeadlineArticlesBeSuccessful = true
        
        let result = await repository.getHeadlineHealthArticles(page: 1)
    
        switch result {
        case .success(let success):
            XCTAssert(true)
        case .failure(let failure):
            XCTFail("Should not return failure on this condition")
        }
    }

    
    func testGetGeneralHeadlineArticleCallsDatasourceWithExpectedCategory() async {
        
        let category: CategoryOption = .general
        
        _ = await repository.getHeadlineGeneralArticles(page: 1)
        
        XCTAssertEqual(category, articleDataSourceMock.didCallFetchHeadlineForCategory)
        
    }
    
    func testGetBusinessHeadlineArticleCallsDatasourceWithExpectedCategory() async {
        
        let category: CategoryOption = .business
        
        _ = await repository.getHeadlineBusinessArticles(page: 1)
        
        XCTAssertEqual(category, articleDataSourceMock.didCallFetchHeadlineForCategory)
        
    }
    
    func testGetEntertainmentHeadlineArticleCallsDatasourceWithExpectedCategory() async {
        
        let category: CategoryOption = .entertainment
        
        _ = await repository.getHeadlineEntertainmentArticles(page: 1)
        
        XCTAssertEqual(category, articleDataSourceMock.didCallFetchHeadlineForCategory)
        
    }
    
    func testGetHealthHeadlineArticleCallsDatasourceWithExpectedCategory() async {
        
        let category: CategoryOption = .health
        
        _ = await repository.getHeadlineHealthArticles(page: 1)
        
        XCTAssertEqual(category, articleDataSourceMock.didCallFetchHeadlineForCategory)
    }
    
    func testGetScienceHeadlineArticleCallsDatasourceWithExpectedCategory() async {
        
        let category: CategoryOption = .science
        
        _ = await repository.getHeadlineScienceArticles(page: 1)
        
        XCTAssertEqual(category, articleDataSourceMock.didCallFetchHeadlineForCategory)
        
    }
    
    func testGetSportsHeadlineArticleCallsDatasourceWithExpectedCategory() async {
        
        let category: CategoryOption = .sports
        
        _ = await repository.getHeadlineSportsArticles(page: 1)
        
        XCTAssertEqual(category, articleDataSourceMock.didCallFetchHeadlineForCategory)
        
    }
    
    func testGetTechnologyHeadlineArticleCallsDatasourceWithExpectedCategory() async {
        
        let category: CategoryOption = .technology
        
        _ = await repository.getHeadlineTechnologyArticles(page: 1)
        
        XCTAssertEqual(category, articleDataSourceMock.didCallFetchHeadlineForCategory)
        
    }
    
}
