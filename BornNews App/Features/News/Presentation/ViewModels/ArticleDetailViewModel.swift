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

class ArticleDetailViewModel {
    
    var article: Article
    
    weak var delegate: ArticleDetailViewModelDelegate?
    
    init(article: Article = Article.getSampleArticles().first!) {
        self.article = article
    
    }
    
    public func viewDidLoad() {
        updateArticle()
    }
    
    private func getArticleImageData(for article: Article) async -> Data? {
        guard let imageURLString = article.urlToImage else { return nil  }
        
        guard let url = URL(string: imageURLString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            
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
