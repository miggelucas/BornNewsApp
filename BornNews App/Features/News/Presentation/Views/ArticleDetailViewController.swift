//
//  DetailViewController.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import UIKit

protocol ArticleDetailComponent {
    var view: UIView { get }
}


class ArticleHeaderViewComponent: ArticleDetailComponent {
    let view: UIView
    
    init(title: String, author: String?, publishedAt: String) {
        let containerView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        
        let authorLabel = UILabel()
        authorLabel.text = author
        authorLabel.font = UIFont.italicSystemFont(ofSize: 16)
        authorLabel.numberOfLines = 0
        
        let dateLabel = UILabel()
        dateLabel.text = publishedAt
        dateLabel.font = UIFont.systemFont(ofSize: 16)
        dateLabel.numberOfLines = 0
        
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
}

class ArticleContentViewComponent: ArticleDetailComponent {
    let view: UIView = UIView()
    
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
    
    init(descriptionArticle: String?, contentArticle: String?) {
        
        articleDescriptionLabel.text = descriptionArticle
        articleContentLabel.text = contentArticle
        
        setupView()
        
    }
    
    func setupView() {
        view.addSubview(articleDescriptionLabel)
        view.addSubview(articleContentLabel)
        
        NSLayoutConstraint.activate([
            articleDescriptionLabel.topAnchor.constraint(equalTo: view.topAnchor),
            articleDescriptionLabel.bottomAnchor.constraint(equalTo: articleContentLabel.topAnchor, constant: 20),
            articleDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            articleDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            articleContentLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            articleContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            articleContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
    }
    
}


class ArticleDetailViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var headerView: ArticleDetailComponent = ArticleHeaderViewComponent(
        title: viewModel.article.title,
        author: viewModel.article.author,
        publishedAt: viewModel.article.publishedAt)
    
    private lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var contentView: ArticleDetailComponent = ArticleContentViewComponent(descriptionArticle: viewModel.article.description, contentArticle: viewModel.article.content)
    
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
//        self.articleDescriptionLabel.text = viewModel.article.description
//        self.articleContentLabel.text = viewModel.article.content
    }
    
    func setupView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(headerView.view)
//        scrollView.addSubview(articleImageView)
//        scrollView.addSubview(contentView.view)

        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.view.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            headerView.view.bottomAnchor.constraint(equalTo: scrollView.topAnchor),
            headerView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            headerView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            
//            articleImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//            articleImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            articleImageView.heightAnchor.constraint(equalToConstant: 200),
//            
//            contentView.view.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 20),
//            contentView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//            contentView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            contentView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
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
