//
//  ViewModelProvider.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 11..
//

import Foundation

struct ViewModelProvider {
    private var model: GitHubRepoSearcher
    
    init(model: GitHubRepoSearcher) {
        self.model = model
    }
    
    func makeRepositorySearchViewModel() -> RepositorySearchViewModel {
        return DefaultRepositorySearchViewModel(model: model)
    }
}
