//
//  DefaultRepositoryViewModel.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 10..
//

import Foundation

class DefaultRepositoryViewModel: RepositoryViewModel {
    var repo: GitHubRepo
    
    init(with repo: GitHubRepo) {
        self.repo = repo
    }
}
