//
//  RepositorySearchViewController.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 09..
//

import UIKit

class RepositorySearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    weak var coordinator: ReposCoordinator?
    
    private var tableView = UITableView()
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: RepositorySearchViewModel

    // MARK: - Life Cycle
    
    init(viewModel: RepositorySearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigationBar()
        setupSearchController()
        
        prepareTableView()
        
        bind(to: viewModel)
    }
    
    // MARK: - Binding
    
    private func bind(to viewModel: RepositorySearchViewModel) {
        viewModel.repos.observe(on: self) { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repos.value.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()

        if indexPath.row == viewModel.repos.value.count - 1 {
            tableView.showLoadingFooter()
            viewModel.fetchMoreRepositories {
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.hideLoadingFooter()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoViewModel = repoViewModel(for: indexPath.row)
        guard let urlString = repoViewModel.repo.htmlUrl else { return }
        
        coordinator?.repoDetailsRequested(with: urlString)
    }
    
    // MARK: - Table View Data Source
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell",
                                                       for: indexPath) as? RepositoryTableViewCell else { return UITableViewCell() }
        let cellViewModel = repoViewModel(for: indexPath.row)
        cell.configure(with: cellViewModel)
        return cell
    }
    
    // MARK: - Search Bar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableView.showLoadingFooter()
        viewModel.fetchRepositories {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.hideLoadingFooter()
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancelSearch()
        viewModel.updateSearchTerm(searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateSearchTerm(searchText)
    }
    
    // MARK: - Helper Methods

    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupNavigationBar() {
        title = NSLocalizedString("GITHUB_REPOS", comment: "Search screen title")
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = NSLocalizedString("SEARCH", comment: "Placeholder for searching")
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        
        searchController.searchBar.delegate = self
    }
    
    private func prepareTableView() {
        tableView.register(UINib(nibName: "RepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "repoCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func repoViewModel(for index: Int) -> RepositoryViewModel {
        guard let repoViewModel = viewModel.repoViewModel(for: index) else { fatalError("❌ repoViewModel cannot be nil") }
        return repoViewModel
    }
}
