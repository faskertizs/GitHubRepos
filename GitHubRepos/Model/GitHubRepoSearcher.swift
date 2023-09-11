//
//  GitHubRepoSearcher.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 11..
//

import Foundation

protocol GitHubRepoSearcher {

    var repos: Observable<[GitHubRepo]> { get }
    var searchTerm: String { get }
    
    func fetchRepositories(completion: @escaping () -> Void)
    func fetchMoreRepositories(completion: @escaping () -> Void)
    func cancelSearch()
    func imageData(for: String, completion: @escaping (Data) -> Void)
    
    // Should be done with binding
    func updateSearchTerm(_ term: String)
}
