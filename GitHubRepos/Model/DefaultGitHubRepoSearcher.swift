//
//  DefaultGitHubRepoSearcher.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 11..
//

import Foundation

class DefaultGitHubRepoSearcher: GitHubRepoSearcher {
    
    private(set) var repos: Observable<[GitHubRepo]> = Observable([])
    private(set) var searchTerm: String = ""
    
    private var currentPage = 0

    private var services = DefaultGitHubServices(networkManager: DefaultNetworkManager())
    
    func fetchRepositories(completion: @escaping () -> Void) {
        self.repos.value = []
        services.repositories(with: searchTerm) { [weak self] repos in
            self?.repos.value = repos
            self?.currentPage = 1
            completion()
        }
    }
    
    func fetchMoreRepositories(completion: @escaping () -> Void) {
        let nextPage = currentPage + 1
        services.repositories(with: searchTerm, page: nextPage) { [weak self] repos in
            if !repos.isEmpty {
                self?.repos.value += repos
                self?.currentPage += 1
            }
            completion()
        }
    }
    
    func cancelSearch() {
        self.repos.value = []
        self.currentPage = 0
    }
    
    func imageData(for urlString: String, completion: @escaping (Data) -> Void)
    {
        services.imageData(for: urlString, completion: completion)
    }
    
    func updateSearchTerm(_ term: String) {
        searchTerm = term
    }
}
