//
//  GitHubServicesMock.swift
//  GitHubReposTests
//
//  Created by Zsuzsa Faskerti on 2023. 09. 09..
//

import Foundation

class GitHubServicesMock: GitHubServices {
    func imageData(for urlString: String, completion: @escaping (Data) -> Void) {
    }
    
    func repositories(with term: String, completion: @escaping ([GitHubRepo]) -> Void) {
        completion(reposMock)
    }
    
    func repositories(with term: String, page: Int, completion: @escaping ([GitHubRepo]) -> Void) {
        completion(reposMock)
    }
    
    var reposMock: [GitHubRepo] = {
        var repos: [GitHubRepo] = []
        if let searchResult = try? GitHubSearchResult.mock() {
            repos = searchResult.items
        }
        return (repos)
    }()
}
