//
//  DescriptionComponentView.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import UIKit

protocol DescriptionComponentViewDelegate: AnyObject {
    func didTapOnKnowMore()
}

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
         label.isUserInteractionEnabled = true
         return label
     }()
     
     private lazy var readMoreLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textColor = .purple
         label.text = "Read more..."
         label.isUserInteractionEnabled = true
         return label
     }()
     
    weak var delegate: DescriptionComponentViewDelegate?
     
     init() {
         setupView()
     }
     
     func configure(with article: Article) {
         articleDescriptionLabel.text = article.summary
         articleContentLabel.text = article.contentFormatted
         
         if let content = article.content, content.count > 200 {
             readMoreLabel.isHidden = false
             readMoreLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleReadMoreTap)))
         } else {
             readMoreLabel.isHidden = true
         }
     }
     
     @objc private func handleReadMoreTap() {
         delegate?.didTapOnKnowMore()
     }
     
     func setupView() {
         view.addSubview(articleDescriptionLabel)
         view.addSubview(articleContentLabel)
         view.addSubview(readMoreLabel)
         
         NSLayoutConstraint.activate([
             articleDescriptionLabel.topAnchor.constraint(equalTo: view.topAnchor),
             articleDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             articleDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             
             articleContentLabel.topAnchor.constraint(equalTo: articleDescriptionLabel.bottomAnchor, constant: 8),
             articleContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             articleContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             
             readMoreLabel.topAnchor.constraint(equalTo: articleContentLabel.bottomAnchor, constant: 8),
             readMoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             readMoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             readMoreLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
     }
}
