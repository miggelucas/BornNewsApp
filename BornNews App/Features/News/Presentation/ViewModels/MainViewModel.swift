//
//  MainViewModel.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func didChangeState()
}

protocol MainViewCoordinatorDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
}

class MainViewModel {
    
    enum State {
        case loading, content
    }
    
    let articleRepository: ArticleRepositoryProtocol
    
    weak var coordinator: MainViewCoordinatorDelegate?
    weak var delegate: MainViewModelDelegate?
    
    var articles: [Article] = []
    var state: State = .loading {
        didSet {
            delegate?.didChangeState()
        }
    }
    
    init(articleRepository: ArticleRepositoryProtocol = ArticleRepository(),
         coordinator: MainViewCoordinatorDelegate? = nil) {
        self.articleRepository = articleRepository
        self.coordinator = coordinator
    }
    
    private func loadArticles() {
        self.state = .loading
        
        Task {
            let result = await articleRepository.getHeadlineArticles()
            
            switch result {
            case .success(let data):
                self.articles = data
               
            case .failure:
                print("ERROR: viewModel Failed to get Articles")
        
            }
            
            self.state = .content
        }
    }
    
    public func viewDidAppear() {
        loadArticles()
    }
    
    public func refreshTableView() {
        loadArticles()
    }
    
    public func didSelectRow(at index: IndexPath) {
        let article = articles[index.row]
        coordinator?.didSelectArticle(article)
    }
}
