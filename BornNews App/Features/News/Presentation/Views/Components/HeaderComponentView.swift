//
//  HeaderComponentView.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import UIKit

class HeaderComponentView: ArticleDetailComponentView {
    var view: UIView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .purple
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var sourceContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.purple.withAlphaComponent(0.1)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.purple.cgColor
        return view
    }()
    
    init() {
        setupView()
    }
    
    func setupView() {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, sourceContainer].forEach {
            mainView.addSubview($0)
        }
        
        [authorLabel, dateLabel, sourceLabel].forEach { sourceContainer.addSubview($0) }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            sourceContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            sourceContainer.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            sourceContainer.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            sourceContainer.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: sourceContainer.topAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: sourceContainer.leadingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: sourceContainer.trailingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: sourceContainer.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: sourceContainer.trailingAnchor, constant: -8),
            
            sourceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            sourceLabel.leadingAnchor.constraint(equalTo: sourceContainer.leadingAnchor, constant: 8),
            sourceLabel.trailingAnchor.constraint(equalTo: sourceContainer.trailingAnchor, constant: -8),
            sourceLabel.bottomAnchor.constraint(equalTo: sourceContainer.bottomAnchor, constant: -8)
        ])
        
        self.view = mainView
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        authorLabel.text = article.authorName
        sourceLabel.text = article.sourceName
        
        if let date = article.publishedDate {
            dateLabel.text = date.DateDescription
        } else {
            dateLabel.text = article.publishedAt
        }
    }
}
