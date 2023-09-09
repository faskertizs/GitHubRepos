//
//  RepositorySearchViewModel.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 09..
//

import Foundation

protocol RepositorySearchViewModel {
    var repos: Observable<[GitHubRepo]> { get }
    var searchTerm: String { get }

    func fetchRepositories()
    
    func updateSearchTerm(_: String)
}
