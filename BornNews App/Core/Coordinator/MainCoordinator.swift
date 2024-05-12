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
    }

    func start() {
        let vc = MainViewController(viewModel: MainViewModel())
        navigationController.pushViewController(vc, animated: false)
    }
}