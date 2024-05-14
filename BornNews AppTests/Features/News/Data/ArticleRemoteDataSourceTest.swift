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
    
    func testCreateHeadlineUrlRequestDoNotThrowsErrorWhenCalledWithInfoOptions() {
        let country: CountryOption = .unitedStates
        let category: CategoryOption = .general
        let page: Int = 0
        
        XCTAssertThrowsError(try dataSource.createHeadlineUrlRequest(country: country, category: category, page: page))
    }
    
    func testCreateHeadlineUrlRequestThrowsErrorWhenCalledWithInvalidParams() {
        let country: CountryOption = .unitedStates
        let category: CategoryOption = .general
        let page: Int = 1
        
        XCTAssertNoThrow(try dataSource.createHeadlineUrlRequest(country: country, category: category, page: page))
    }
    
    func testCreateHeadlineUrlRequestReturnsExpectedUrlString() {
        let country: CountryOption = .unitedStates
        let category: CategoryOption = .general
        let page: Int = 1
        
        do {
            let request = try dataSource.createHeadlineUrlRequest(country: country, category: category, page: page)
            
            let expectedUrl = "https://newsapi.org/v2/top-headlines?\(ApiKey.key)=\(ApiKey.value)&\(country.key)=\(country.value)&\(category.key)=\(category.value)&page=\(page)"
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
        } catch let error {
            XCTAssertNil(error)
        }
    }
    
}
