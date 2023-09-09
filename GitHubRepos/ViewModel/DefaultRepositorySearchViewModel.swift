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

    private(set) var repos: [GitHubRepo] = []
    private(set) var searchTerm: String = "term"
    
    func fetchRepositories() {
        gitHubServices.repositories(with: searchTerm) { [weak self] repos in
            self?.repos = repos
        }
    }
}
