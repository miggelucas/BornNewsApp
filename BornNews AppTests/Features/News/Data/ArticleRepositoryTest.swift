//
//  ArticleRepositoryTest.swift
//  BornNews AppTests
//
//  Created by Lucas Migge on 11/05/24.
//

import XCTest
@testable import BornNews_App

class RemoteArticleDataSourceMock: ArticleRemoteDataSourceProtocol {
    
    var shouldFetchBeSuccessful: Bool = true
    var didCallFetchHeadlineArticles: Bool = false
    var didCallFetchSearchArticles: Bool = false
    
    var didCallFetchHeadlineForCategory: CategoryOption?
    
    func fetchHeadlineArticles(country: CountryOption, category: CategoryOption, page: Int) async throws -> [ArticleModel] {
        
        didCallFetchHeadlineArticles = true
        didCallFetchHeadlineForCategory = category

        if shouldFetchBeSuccessful {
            return []
        } else {
            throw RemoteDataSourceError.failedToFetch
        }
    }
    
    func fetchSearchArticles(query: QueryOption, language: LanguageOption, page: Int) async throws -> [ArticleModel] {
        
        didCallFetchSearchArticles = true

        if shouldFetchBeSuccessful {
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
        let article1 = ArticleModel(source: SourceModel(name: "test"),  title: "Awesome Title", url: "google.com", publishedAt: "today")
        let article2 = ArticleModel(source: SourceModel(name: "test"),  title: "[Removed]", url: "google.com", publishedAt: "someday")
        let article3 = ArticleModel(source: SourceModel(name: "test"),  title: "Great Article", url: "google.com", publishedAt: "12/05/99")
        
        let filteredArticles = repository.removeInvalidArticles(for: [article1, article2, article3])
        
        XCTAssertFalse(filteredArticles.contains(where: {$0.title == article2.title}))
        XCTAssertEqual(filteredArticles.count, 2)
    }
    
    func testGetHeadlineArticlesReturnSuccessWhenSuccessfulCallWithDatasource() async {
        
        articleDataSourceMock.shouldFetchBeSuccessful = true
        
        let result = await repository.getHeadlineHealthArticles(page: 1)
        
        XCTAssertNoThrow(try result.get())
    }
    
    func testGetHeadlineArticlesReturnFailureWhenCallWithDatasourceFails() async {
        
        articleDataSourceMock.shouldFetchBeSuccessful = true
        
        let result = await repository.getHeadlineHealthArticles(page: 1)
    
        switch result {
        case .success(_):
            XCTAssert(true)
        case .failure(_):
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
