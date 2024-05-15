//
//  MainCoordinatorTests.swift
//  BornNews AppTests
//
//  Created by Lucas Migge on 15/05/24.
//

import XCTest
@testable import BornNews_App

final class MainCoordinatorTests: XCTestCase {

    var navigation: UINavigationController!
    var coordinator: MainCoordinator!
    
    override func setUp() {
        super.setUp()
        navigation = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigation)
    }
    
    override func tearDown() {
        super.tearDown()
        
        navigation = nil
        coordinator = nil
    }
    
    func testStartShouldAppendVCToNavigationController() {
        navigation.viewControllers = []
        
        coordinator.start()
        
        XCTAssertFalse(navigation.viewControllers.isEmpty)
    }
    
    func testStartShouldAppendToNavigationAMainVC() {
        navigation.viewControllers = []
        
        coordinator.start()
        
        let vc = navigation.viewControllers.first
        
        XCTAssertTrue(vc is MainViewController)
    }
    
    
    func testDidSelectArticleShouldPushArticleDetailVMToNavigationController() {
        
        coordinator.didSelectArticle(ArticleModel.getSample())
        
        let vc = navigation.viewControllers.last
        
        XCTAssertTrue(vc is ArticleDetailViewController)

    }
}
