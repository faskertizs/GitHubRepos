//
//  DefaultRepositoryViewModel.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 10..
//

import Foundation

class DefaultRepositoryViewModel: RepositoryViewModel {
    
    var repo: GitHubRepo
    var gitHubServices: GitHubServices!
    
    init(with repo: GitHubRepo, gitHubServices: GitHubServices) {
        self.repo = repo
        self.gitHubServices = gitHubServices
    }
    
    func imageData(for urlString: String, completion: @escaping (Data) -> Void) {
        gitHubServices.imageData(for: urlString) { data in
            completion(data)
        }
    }
}
