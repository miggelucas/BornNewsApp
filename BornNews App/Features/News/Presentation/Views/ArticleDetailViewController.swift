//
//  DetailViewController.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import UIKit



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
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private lazy var DescriptionView: DescriptionComponentView = {
        let descriptionView = DescriptionComponentView()
        descriptionView.delegate = viewModel
        return descriptionView
    }()
    
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
        DescriptionView.configure(with: viewModel.article)
    }
    
    func setupView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(headerView.view)
        scrollView.addSubview(articleImageView)
        scrollView.addSubview(DescriptionView.view)
        
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

                
                DescriptionView.view.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 20),
                DescriptionView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                DescriptionView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
                DescriptionView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
                DescriptionView.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
                
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
