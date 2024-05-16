//
//  ArticleTableViewCell.swift
//  BornNews App
//
//  Created by Lucas Migge on 12/05/24.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    static let identifier = "ArticleTableViewCellIdentifier"
    
    // MARK: - Properties
    
    private let mainContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.purple.cgColor
        return view
    }()
    
    private let imageContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private let loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .medium)
        loadingView.color = .purple
        loadingView.hidesWhenStopped = true
        return loadingView
    }()
    
    private let articleImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.isHidden = true

        return view
    }()
    
    private let labelsContainer: UIView = {
        let view = UIView()

        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let viewModel: ArticleTableCellViewModel = ArticleTableCellViewModel()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewModel.delegate = self
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupSubviews() {
        contentView.addSubview(mainContainer)
        
        mainContainer.addSubview(imageContainer)
        mainContainer.addSubview(labelsContainer)
        
        imageContainer.addSubview(loadingView)
        imageContainer.addSubview(articleImageView)
        
        labelsContainer.addSubview(titleLabel)
        labelsContainer.addSubview(authorLabel)
        labelsContainer.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        [mainContainer, imageContainer, loadingView, articleImageView, labelsContainer, titleLabel, authorLabel, descriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            imageContainer.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            imageContainer.heightAnchor.constraint(equalToConstant: 200),
            
            articleImageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            articleImageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 200),
            
            loadingView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 200),
            
            labelsContainer.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 8),
            labelsContainer.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
            labelsContainer.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),
            labelsContainer.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: labelsContainer.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: labelsContainer.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        authorLabel.text = "Author: \(article.authorName)"
        descriptionLabel.text = article.summary
        articleImageView.image = UIImage(systemName: "newspaper")
        articleImageView.isHidden = true
        loadingView.startAnimating()
        
        viewModel.didCallConfigure(for: article)
    }
}

extension ArticleTableViewCell: ArticleTableCellViewModelDelegate {
    func shouldUpdateImageView(with imageData: Data) {
        DispatchQueue.main.sync {
            self.articleImageView.image = UIImage(data: imageData)
        }
    }
    
    func didFinishFetchingImageData() {
        DispatchQueue.main.sync {
            self.articleImageView.isHidden = false
            self.loadingView.stopAnimating()
        }
    }
}

