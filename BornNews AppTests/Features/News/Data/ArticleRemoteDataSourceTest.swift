//
//  ArticleRemoteDataSourceTest.swift
//  BornNews AppTests
//
//  Created by Lucas Migge on 11/05/24.
//

import XCTest
@testable import BornNews_App


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
    
    func testCreateHeadlineUrlRequestThrowsErrorWhenCalledWithInvalidParams() {
        let country: CountryOption = .unitedStates
        let category: CategoryOption = .general
        let page: Int = 0
        
        XCTAssertThrowsError(try dataSource.createHeadlineUrlRequest(country: country, category: category, page: page))
    }
    
    func testCreateHeadlineUrlRequestDoNotThrowsErrorWhenCalledWithInfoOptions() {
        let country: CountryOption = .unitedStates
        let category: CategoryOption = .general
        let page: Int = 1
        
        XCTAssertNoThrow(try dataSource.createHeadlineUrlRequest(country: country, category: category, page: page))
    }
    
    func testCreateHeadlineUrlRequestReturnsExpectedUrlString() {
        let apiKey = dataSource.apiKey
        
        let country: CountryOption = .unitedStates
        let category: CategoryOption = .general
        let page: Int = 1
        
        do {
            let request = try dataSource.createHeadlineUrlRequest(country: country, category: category, page: page)
            
            let expectedUrl = "https://newsapi.org/v2/top-headlines?\(apiKey.key)=\(apiKey.value)&\(country.key)=\(country.value)&\(category.key)=\(category.value)&page=\(page)"
            let url = request.url?.absoluteString
            
            XCTAssertEqual(expectedUrl, url)
            
        } catch let error {
            XCTAssertNotNil(error)
        }
    }
    

    func testFetchHeadlineArticlesThrowsErrorWhenCalledWithInvalidParams() async {
        let country: CountryOption = .unitedStates
        let category: CategoryOption = .general
        let page: Int = -1
        
        do {
            _ = try await dataSource.fetchHeadlineArticles(country: country, category: category, page: page)
            
            XCTFail("Should throw error on this condition")
        } catch let error {
            XCTAssertNotNil(error)
        }
    }
    
    func testFetchHeadlineArticlesReturnsArticlesWithoutErrorWithValidParams() async {
        networkSessionMock.shouldThrowError = false
        let country: CountryOption = .unitedStates
        let category: CategoryOption = .general
        let page: Int = 1
        
        do {
            let articles = try await dataSource.fetchHeadlineArticles(country: country, category: category, page: page)
            
            XCTAssertFalse(articles.isEmpty)
        } catch  {
            XCTFail("Should not have a erro to catch on this condition")
        }
    }
    
    func testCreateSearchArticleUrlRequestDoNotThrowsErrorWhenCalledWithInfoOptions() {
        let query: QueryOption = QueryOption(queryFor: "Apple")
        let language: LanguageOption = .english
        let page: Int = 1
        
        XCTAssertNoThrow(try dataSource.createSearchUrlRequest(query: query, language: language, page: page))
    }
    
    func testCreateSearchArticleUrlRequestThrowsErrorWhenCalledWithInvalidPageParam() {
        let query: QueryOption = QueryOption(queryFor: "Apple")
        let language: LanguageOption = .english
        let page: Int = 0
        
        XCTAssertThrowsError(try dataSource.createSearchUrlRequest(query: query, language: language, page: page))
    }
    
    func testCreateSearchArticleUrlRequestThrowsErrorWhenCalledWithInvalidQueryParam() {
        let query: QueryOption = QueryOption(queryFor: "")
        let language: LanguageOption = .english
        let page: Int = 1
        
        XCTAssertThrowsError(try dataSource.createSearchUrlRequest(query: query, language: language, page: page))
    }
    
    func testCreateSearchArticleUrlRequestReturnsExpectedUrlString() {
        let apiKey = dataSource.apiKey
        
        let query: QueryOption = QueryOption(queryFor: "Apple")
        let language: LanguageOption = .english
        let page: Int = 1
        
        do {
            let request = try dataSource.createSearchUrlRequest(query: query, language: language, page: page)
            
            let expectedUrl = "https://newsapi.org/v2/everything?\(apiKey.key)=\(apiKey.value)&\(language.key)=\(language.value)&\(query.key)=\(query.value)&page=\(page)"
            let url = request.url?.absoluteString
            
            XCTAssertEqual(expectedUrl, url)
            
        } catch {
            XCTFail("Should not have a erro to catch on this condition")
        }
    }
    
    func testFetchSearchArticlesThrowsErrorWhenCalledWithInvalidParams() async {
        let query: QueryOption = QueryOption(queryFor: "Apple")
        let language: LanguageOption = .english
        let page: Int = -1

        do {
            _ = try await dataSource.fetchSearchArticles(query: query, language: language, page: page)
            
            XCTFail("Should throw error on this condition")
        } catch let error {
            XCTAssertNotNil(error)
        }
    }
    
    func testFetchSearchArticlesReturnsArticlesWithoutErrorWithValidParams() async {
        networkSessionMock.shouldThrowError = false
        
        let query: QueryOption = QueryOption(queryFor: "Apple")
        let language: LanguageOption = .english
        let page: Int = 1
        
        do {
            let articles = try await dataSource.fetchSearchArticles(query: query, language: language, page: page)
            
            XCTAssertFalse(articles.isEmpty)
        } catch {
            XCTFail("Should not throw error on this condition")
        }
    }
    
}
