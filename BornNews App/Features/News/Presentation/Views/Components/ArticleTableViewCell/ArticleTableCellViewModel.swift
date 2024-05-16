//
//  ArticleTableCellViewModel.swift
//  BornNews App
//
//  Created by Lucas Migge on 15/05/24.
//

import Foundation

protocol ArticleTableCellViewModelDelegate: AnyObject {
    func shouldUpdateImageView(with imageData: Data)
    
    func didFinishFetchingImageData()
}

class ArticleTableCellViewModel {
    
    var currentArticle: Article?
    let networkSession: NetworkSession
    
    weak var delegate: ArticleTableCellViewModelDelegate?
    
    init(networkSession: NetworkSession = URLSession.shared, delegate: ArticleTableCellViewModelDelegate? = nil) {
        self.networkSession = networkSession
        self.delegate = delegate
    }
    
    func didCallConfigure(for article: Article) {
        currentArticle = article
        updateArticleImage(for: article)
        
    }
    
    private func updateArticleImage(for article: Article) {
        Task {
            guard let imageData = await fetchArticleImageData(for: article), currentArticle?.urlToImage == article.urlToImage else {
                delegate?.didFinishFetchingImageData()
                return
            }
            
            delegate?.shouldUpdateImageView(with: imageData)
            delegate?.didFinishFetchingImageData()
        }
    }
    
    private func fetchArticleImageData(for article: Article) async -> Data? {
        guard let imageURLString = article.urlToImage, let url = URL(string: imageURLString) else {
            return nil
        }
        
        do {
            let (data, _) = try await networkSession.data(for: URLRequest(url: url), delegate: nil)
            return data
        } catch {
            print("Failed to download image: \(error.localizedDescription)")
            return nil
        }
    }
    
}
