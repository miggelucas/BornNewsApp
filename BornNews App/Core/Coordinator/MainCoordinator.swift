//
//  MainCoordinator.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        self.navigationController.navigationBar.tintColor = .purple
    }

    func start() {
        let viewModel = MainViewModel(coordinator: self)
        let vc = MainViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
}

extension MainCoordinator: MainViewModelCoordinatorDelegate {
    func didSelectArticle(_ article: Article) {
        
        let viewModel = ArticleDetailViewModel(article: article, coordinator: self)
        let vc = ArticleDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension MainCoordinator: ArticleDetailViewModelCoordinator {
    func goToLink(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
