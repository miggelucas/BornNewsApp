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
    
    private let imageContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .medium)
        loadingView.color = .purple
        loadingView.hidesWhenStopped = true
        return loadingView
    }()
    
    private let articleImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "paperplane"))
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.isHidden = true
        return view
    }()
    
    private let labelsContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
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
        contentView.addSubview(imageContainer)
        contentView.addSubview(labelsContainer)
        
        imageContainer.addSubview(loadingView)
        imageContainer.addSubview(articleImageView)
        
        labelsContainer.addSubview(titleLabel)
        labelsContainer.addSubview(authorLabel)
        labelsContainer.addSubview(publishedAtLabel)
    }
    
    private func setupConstraints() {
        [imageContainer, loadingView, articleImageView, labelsContainer, titleLabel, authorLabel, publishedAtLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageContainer.heightAnchor.constraint(equalToConstant: 200),
            
            articleImageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            articleImageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            
            labelsContainer.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 8),
            labelsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            labelsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            labelsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: labelsContainer.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor, constant: -16),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor, constant: -16),
            
            publishedAtLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            publishedAtLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor, constant: 16),
            publishedAtLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor, constant: -16),
            publishedAtLabel.bottomAnchor.constraint(equalTo: labelsContainer.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        authorLabel.text = article.authorName
        publishedAtLabel.text = article.publishedDate?.shortDateDescription() ?? article.publishedAt
        articleImageView.image = UIImage(systemName: "newspaper") // Clear the image
        articleImageView.isHidden = true // Hide image view initially
        loadingView.startAnimating() // Start loading indicator
        
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
