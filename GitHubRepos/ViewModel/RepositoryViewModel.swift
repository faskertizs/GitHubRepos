//
//  RepositoryViewModel.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 10..
//

import Foundation

class RepositoryViewModel: RepositoryViewModelProtocol {
    
    var repo: GitHubRepo
    var model: GitHubRepoSearcherProtocol
    
    init(with repo: GitHubRepo, model: GitHubRepoSearcherProtocol) {
        self.repo = repo
        self.model = model
    }
    
    func imageData(for urlString: String, completion: @escaping (Data) -> Void) {
        model.imageData(for: urlString) { data in
            completion(data)
        }
    }
}
