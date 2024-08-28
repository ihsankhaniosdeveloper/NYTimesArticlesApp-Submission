//
//  ArticlesViewController.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import UIKit
import Combine
class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ArticlesViewModelProtocol!
    private var cancellables = Set<AnyCancellable>()
    var coordinator: ArticlesCoordinatorProtocol!
    
    // Required dependencies initializer
    init?(coder: NSCoder, viewModel: ArticlesViewModelProtocol, coordinator: ArticlesCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must use init(coder:viewModel:coordinator:) instead")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarTitle()
        setupTableView()
        bindViewModel()
        loadArticles()
    }
    
    private func setupNavigationBarTitle() {
        self.title = "Most Popular Articles"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // Load articles
    private func loadArticles() {
        // Show the loader
        self.displayLoadingIndicator()
        self.viewModel.loadArticles(section: "all-sections", period: 7)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // Register the Cell
        tableView.registerCell(ofType: ArticleTableViewCell.self)
        tableView.estimatedRowHeight = 110
    }
    
    private func bindViewModel() {
        viewModel.articlesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                // Hide loader
                
                self?.hideLoadingIndicator()
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.errorMessagePublisher
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.hideLoadingIndicator()
                self?.showErrorAlert(message: errorMessage)
            }
            .store(in: &cancellables)
    }
}


