//
//  RepositoryViewModelProtocol.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 10..
//

import Foundation

protocol RepositoryViewModelProtocol {
    var repo: GitHubRepo { get }
    var model: GitHubRepoSearcherProtocol { get }

    func imageData(for: String, completion: @escaping (Data) -> Void)
}
