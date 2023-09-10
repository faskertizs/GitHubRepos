//
//  RepositoryViewModel.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 10..
//

import Foundation

protocol RepositoryViewModel {
    var repo: GitHubRepo { get }
    var gitHubServices: GitHubServices! { get }

    func imageData(for: String, completion: @escaping (Data) -> Void)
}
