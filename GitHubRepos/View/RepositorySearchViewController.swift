//
//  RepositorySearchViewController.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 09..
//

import UIKit

class RepositorySearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let heightOfSearchBar: CGFloat = 50.0

    private var tableView = UITableView()
    
    private var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigationBar()
        setupSearchController()
        
        prepareTableView()
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    // MARK: - Table View Data Source
    
    var cellText = "Repository"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(cellText) \(indexPath.row)"
        return cell
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
    }
    
    private func prepareTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}
