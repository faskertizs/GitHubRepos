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
    
    func fetchRepositories() {
        gitHubServices.repositories(with: searchTerm) { [weak self] repos in
            self?.repos.value = repos
        }
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
