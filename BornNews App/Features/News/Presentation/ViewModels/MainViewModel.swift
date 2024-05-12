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
        articleRepository.getHeadlineArticles { [weak self] result in
            switch result {
            case .success(let data):
                self?.articles = data
                self?.delegate?.didUpdateArticles()
            case .failure:
                print("ERROR: viewModel Failed to get Articles")
                return
            }
        }
    }
    
    public func viewDidAppear() {
        loadArticles()
    }
}
