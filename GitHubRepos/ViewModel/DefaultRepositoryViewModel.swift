//
//  DefaultRepositoryViewModel.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 10..
//

import Foundation

class DefaultRepositoryViewModel: RepositoryViewModel {
    
    var repo: GitHubRepo
    var model: GitHubRepoSearcher
    
    init(with repo: GitHubRepo, model: GitHubRepoSearcher) {
        self.repo = repo
        self.model = model
    }
    
    func imageData(for urlString: String, completion: @escaping (Data) -> Void) {
        model.imageData(for: urlString) { data in
            completion(data)
        }
    }
}
