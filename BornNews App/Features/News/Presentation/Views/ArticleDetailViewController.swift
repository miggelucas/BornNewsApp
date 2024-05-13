//
//  DetailViewController.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import UIKit

protocol ArticleDetailComponent {
    var view: UIView { get }
    
    func configure(with article: Article)
}


class ArticleHeaderViewComponent: ArticleDetailComponent {
    var view: UIView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    
    init() {
        setupView()
    }
    
    func setupView() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, authorLabel, dateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        
        self.view = containerView
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        authorLabel.text = article.author
        dateLabel.text = article.publishedAt
    }
    
}

class ArticleContentViewComponent: ArticleDetailComponent {
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
    
    func configure(with article: Article) {
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


class ArticleDetailViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var headerView: ArticleHeaderViewComponent = ArticleHeaderViewComponent()
    
    private lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var contentView: ArticleDetailComponent = ArticleContentViewComponent()
    
    let viewModel: ArticleDetailViewModel
    
    init(viewModel: ArticleDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupContent()
        viewModel.viewDidLoad()
    }
    
    private func setupContent() {
        headerView.configure(with: viewModel.article)
        contentView.configure(with: viewModel.article)
    }
    
    func setupView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(headerView.view)
        scrollView.addSubview(articleImageView)
        scrollView.addSubview(contentView.view)
        
        NSLayoutConstraint.activate([
                
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                
                
                headerView.view.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
                headerView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                headerView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
                headerView.view.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -40),
                
                // Constraints for articleImageView
                articleImageView.topAnchor.constraint(equalTo: headerView.view.bottomAnchor, constant: 20),
                articleImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                articleImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
                articleImageView.heightAnchor.constraint(equalToConstant: 200),
                articleImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -40), // Ajuste conforme necessário
                
                contentView.view.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 20),
                contentView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                contentView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
                contentView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
                contentView.view.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -40)
                
            ])
    }
}

extension ArticleDetailViewController: ArticleDetailViewModelDelegate {
    func shouldUpdateArticleImage(uiImage: UIImage) {
        DispatchQueue.main.async {
            self.articleImageView.image = uiImage
        }
    }
}


// MARK: - Preview
#if DEBUG
import SwiftUI

struct ArticleDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(rootViewController:
                                    ArticleDetailViewController(viewModel: ArticleDetailViewModel()))
        }
    }
}#endif
