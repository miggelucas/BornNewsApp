//
//  MainViewController.swift
//  BornNews App
//
//  Created by Lucas Migge on 11/05/24.
//

import UIKit

class MainViewController: UIViewController {
    
    let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Properties
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    let refreshControl = UIRefreshControl()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.color = .purple
        return loadingView
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        viewModel.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationController()
    }
    
    // MARK: - Setup
    
    private func setupNavigationController() {
        self.title = "BornNews"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViews() {
        setupTableView()
        setupRefreshControl()
        setupLoadingView()
        
    }
    
    private func setupLoadingView() {
        loadingView.startAnimating()
        view.addSubview(loadingView)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        tableView.isHidden = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
              tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        refreshControl.tintColor = .purple
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshControlAction() {
        viewModel.didRefreshTableView()
    }
}

// MARK: - MainViewModelDelegate

extension MainViewController: MainViewModelDelegate {
    func shouldPresentContentState() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableView.isHidden = false
            self.loadingView.isHidden = true
            self.loadingView.stopAnimating()
        }
    }
    
    func shouldReloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: viewModel.articles[indexPath.row])
        return cell
        
    }
    
    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        cell.textLabel?.text = viewModel.articles[indexPath.row].title
        cell.textLabel?.textColor = .black
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            viewModel.didScrollToTheEnd()
        }
    }
}


// MARK: - Preview
#if DEBUG
import SwiftUI

struct ProductViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(rootViewController: MainViewController(viewModel: MainViewModel()))
        }
    }
}#endif
