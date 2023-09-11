//
//  ViewModelProvider.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 11..
//

import Foundation

struct ViewModelProvider {
    private var model: GitHubRepoSearcherProtocol
    
    init(model: GitHubRepoSearcherProtocol) {
        self.model = model
    }
    
    func makeRepositorySearchViewModel() -> RepositorySearchViewModelProtocol {
        return RepositorySearchViewModel(model: model)
    }
}
