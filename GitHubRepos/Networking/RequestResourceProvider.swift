//
//  RequestResourceProvider.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

struct RequestResourceProvider {
    static func requestResourceForGitHubRepositorySearch(term: String) -> RequestResource {
        let searchEndpoint = "https://api.github.com/search/repositories"
        let searchTerm = term
        
        return RequestResource(httpMethod: .get,
                               endpoint: searchEndpoint,
                               queryItems: [URLQueryItem(name: "q", value: searchTerm)])
    }
}
