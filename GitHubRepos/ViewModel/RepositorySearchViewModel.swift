//
//  RepositorySearchViewModel.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 09..
//

import Foundation

protocol RepositorySearchViewModel {
    
    var model: GitHubRepoSearcher { get }
    
    var repos: Observable<[GitHubRepo]> { get }
    
    func fetchRepositories(completion: @escaping () -> Void)
    func fetchMoreRepositories(completion: @escaping () -> Void)
    func cancelSearch()
    
    func repoViewModel(for index: Int) -> RepositoryViewModel?
    
    // Should be done with binding
    func updateSearchTerm(_ term: String)
}
