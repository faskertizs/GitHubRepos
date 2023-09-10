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

    func fetchRepositories(completion: @escaping () -> Void)
    func fetchMoreRepositories(completion: @escaping () -> Void)
    func cancelSearch()

    // Should be done with binding
    func updateSearchTerm(_: String)
    
    func repoViewModel(for index: Int) -> RepositoryViewModel?
}
