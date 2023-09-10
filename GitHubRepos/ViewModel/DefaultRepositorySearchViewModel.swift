//
//  DefaultRepositorySearchViewModel.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 09..
//

import Foundation

class DefaultRepositorySearchViewModel: RepositorySearchViewModel {
    
    var gitHubServices: GitHubServices!
    
    init(gitHubServices: GitHubServices!) {
        self.gitHubServices = gitHubServices
    }

    private(set) var repos: Observable<[GitHubRepo]> = Observable([])
    private(set) var searchTerm: String = ""
    var currentPage = 0
    
    func fetchRepositories(completion: @escaping () -> Void) {
        self.repos.value = []
        gitHubServices.repositories(with: searchTerm) { [weak self] repos in
            self?.repos.value = repos
            self?.currentPage = 1
            completion()
        }
    }
    
    func fetchMoreRepositories(completion: @escaping () -> Void) {
        let nextPage = currentPage + 1
        gitHubServices.repositories(with: searchTerm, page: nextPage) { [weak self] repos in
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

    func updateSearchTerm(_ term: String) {
        searchTerm = term
    }
    
    func repoViewModel(for index: Int) -> RepositoryViewModel? {
        if index < repos.value.count, index >= 0 {
            let repo = repos.value[index]
            return DefaultRepositoryViewModel(with: repo, gitHubServices: gitHubServices)
        }
        return nil
    }
}
