//
//  RepositorySearchViewController.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 09..
//

import UIKit

class RepositorySearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private var tableView = UITableView()
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: RepositorySearchViewModel!

    // MARK: - Life Cycle
    
    init(viewModel: RepositorySearchViewModel!) {
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
    
    // MARK: - Table View Data Source
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.repos.value[indexPath.row].name
        return cell
    }
    
    // MARK: - Search Bar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchController.searchBar.text else { return }
        viewModel.updateSearchTerm(term)
        viewModel.fetchRepositories()
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
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.delegate = self
    }
    
    private func prepareTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}
