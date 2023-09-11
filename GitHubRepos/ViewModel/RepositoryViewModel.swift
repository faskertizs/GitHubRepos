//
//  RepositoryViewModel.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 10..
//

import Foundation

protocol RepositoryViewModel {
    var repo: GitHubRepo { get }
    var model: GitHubRepoSearcher { get }

    func imageData(for: String, completion: @escaping (Data) -> Void)
}
