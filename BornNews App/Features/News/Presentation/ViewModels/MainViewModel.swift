//
//  MainViewModel.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func shouldPresentContentState()
    func shouldReloadTable()
}

protocol MainViewCoordinatorDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
}

class MainViewModel {
    
    enum State {
        case launching, content, fetching
    }
    
    let articleRepository: ArticleRepositoryProtocol
    
    weak var coordinator: MainViewCoordinatorDelegate?
    weak var delegate: MainViewModelDelegate?
    
    var canLoadMoreArticles: Bool = true
    var articlePage: Int = 1
    
    var articles: [Article] = []
    var countryOption: CountryOption = .unitedStates
    var categoryOption: CategoryOption = .general
    
    var state: State = .launching { 
        didSet {
             if state != .launching {
                delegate?.shouldPresentContentState()
            }
        }
    }
    
    init(articleRepository: ArticleRepositoryProtocol = ArticleRepository(),
         coordinator: MainViewCoordinatorDelegate? = nil) {
        self.articleRepository = articleRepository
        self.coordinator = coordinator
    }
    
    private func loadArticles() {
        Task {
            let result = await articleRepository.getHeadlineArticles(country: countryOption,
                                                                     category: categoryOption,
                                                                     page: articlePage)
            switch result {
            case .success(let fetchedArticles):
                self.articles.append(contentsOf: fetchedArticles)
                delegate?.shouldReloadTable()
                state = .content
                
            case .failure(let error):
                
                delegate?.shouldPresentContentState()
                
                switch error {
                case .noMoreData:
                    canLoadMoreArticles = false
                    state = .content
                default:
                    state = .content
                    
                }
            }
        }
    }
    
    public func viewDidLoad() {
        loadArticles()
    }
    
    public func didRefreshTableView() {
        articlePage = 1
        state = .fetching
        loadArticles()
    }
    
    public func didSelectRow(at index: IndexPath) {
        let article = articles[index.row]
        coordinator?.didSelectArticle(article)
    }
    
    public func didScrollToTheEnd() {
        
        guard state == .content else { return }
        guard canLoadMoreArticles else { return }
        
        articlePage += 1
        state = .fetching
        loadArticles()
    }
}
