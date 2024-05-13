//
//  DetailViewController.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import UIKit

protocol ArticleDetailComponentView {
    var view: UIView { get }
    
    func configure(with article: Article)
}

class ArticleDetailViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var headerView: HeaderComponentView = HeaderComponentView()
    
    private lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var contentView: ArticleDetailComponentView = DescriptionComponentView()
    
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
        self.title = "Article"
        navigationItem.largeTitleDisplayMode = .never
        
        setupView()
        setupContent()
        viewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
                headerView.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
                
                // Constraints for articleImageView
                articleImageView.topAnchor.constraint(equalTo: headerView.view.bottomAnchor, constant: 20),
                articleImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                articleImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
                articleImageView.heightAnchor.constraint(equalToConstant: 200),

                
                contentView.view.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 20),
                contentView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                contentView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
                contentView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
                contentView.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
                
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
