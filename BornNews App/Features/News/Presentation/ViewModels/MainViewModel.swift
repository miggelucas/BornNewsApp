//
//  MainViewModel.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func didUpdateArticles()
}

class MainViewModel {
    
    let articleRepository: ArticleRepositoryProtocol
    
    var articles: [Article] = []
    
    init(articleRepository: ArticleRepositoryProtocol = ArticleRepository()) {
        self.articleRepository = articleRepository
    }
    
    weak var delegate: MainViewModelDelegate?
    
    func loadArticles() {
        Task {
            let result = await articleRepository.getHeadlineArticles()
            switch result {
            case .success(let data):
                self.articles = data
                delegate?.didUpdateArticles()
            case .failure:
                print("ERROR: viewModel Failed to get Articles")
                return
            }
        }
    }
    
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    public func viewDidAppear() {
        loadArticles()
    }
}
