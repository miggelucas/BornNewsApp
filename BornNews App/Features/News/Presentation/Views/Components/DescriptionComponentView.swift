//
//  DescriptionComponentView.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import UIKit


class DescriptionComponentView: ArticleDetailComponentView {
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var articleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var articleContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    init() {
        setupView()
    }
    
    public func configure(with article: Article) {
        articleDescriptionLabel.text = article.description
        articleContentLabel.text = article.content
    }
    
    func setupView() {
        view.addSubview(articleDescriptionLabel)
        view.addSubview(articleContentLabel)
        
        NSLayoutConstraint.activate([
            articleDescriptionLabel.topAnchor.constraint(equalTo: view.topAnchor),
            articleDescriptionLabel.bottomAnchor.constraint(equalTo: articleContentLabel.topAnchor, constant: -20),
            articleDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articleDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            articleContentLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            articleContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articleContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
