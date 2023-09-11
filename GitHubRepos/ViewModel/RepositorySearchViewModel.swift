//
//  RepositorySearchViewModel.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 09..
//

import Foundation

class RepositorySearchViewModel: RepositorySearchViewModelProtocol {
    
    var model: GitHubRepoSearcherProtocol

    var repos: Observable<[GitHubRepo]> {
        get {
            model.repos
        }
    }

    init(model: GitHubRepoSearcherProtocol) {
        self.model = model
    }

    func fetchRepositories(completion: @escaping () -> Void) {
        model.fetchRepositories(completion: completion)
    }
    
    func fetchMoreRepositories(completion: @escaping () -> Void) {
        model.fetchMoreRepositories(completion: completion)
    }
    
    func cancelSearch() {
        model.cancelSearch()
    }

    func updateSearchTerm(_ term: String) {
        model.updateSearchTerm(term)
    }
    
    func repoViewModel(for index: Int) -> RepositoryViewModelProtocol? {
        if index < model.repos.value.count, index >= 0 {
            let repo = model.repos.value[index]
            return RepositoryViewModel(with: repo, model: model)
        }
        return nil
    }
}
