//
//  ArticleDetailViewModel.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import Foundation
import UIKit

protocol ArticleDetailViewModelDelegate: AnyObject {
    func shouldUpdateArticleImage(uiImage: UIImage)
}

protocol ArticleDetailViewModelCoordinator: AnyObject {
    func goToLink(url: URL)
}


class ArticleDetailViewModel {
    
    var article: Article
    
    var networkSession: NetworkSession
    
    weak var delegate: ArticleDetailViewModelDelegate?
    weak var coordinator: ArticleDetailViewModelCoordinator?
    
    init(article: Article = ArticleModel.getSample(), coordinator: ArticleDetailViewModelCoordinator? = nil, networkSession: NetworkSession = URLSession.shared) {
        self.article = article
        self.coordinator = coordinator
        self.networkSession = networkSession
    
    }
    
    public func viewDidLoad() {
        updateArticle()
    }
    
    private func getArticleImageData(for article: Article) async -> Data? {
        guard let imageURLString = article.urlToImage else { return nil  }
        
        guard let url = URL(string: imageURLString) else { return nil }
        
        do {
            let (data, _) = try await networkSession.data(for: URLRequest(url: url), delegate: nil)
            
            return data

        } catch {
            print("Failed to download image")
            return nil
        }
    }
    
    private func updateArticle() {
        Task {
            guard let imageData = await getArticleImageData(for: self.article) else { return }
            
            guard let uiImage = UIImage(data: imageData) else { return }
            
            delegate?.shouldUpdateArticleImage(uiImage: uiImage)
        }
    }
}

extension ArticleDetailViewModel: DescriptionComponentViewDelegate {
    func didTapOnKnowMore() {
        guard let url = URL(string: article.url) else { return }
        coordinator?.goToLink(url: url)
    }
}
