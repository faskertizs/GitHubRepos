//
//  RequestResourceProvider.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

struct RequestResourceProvider {
    static func requestResourceForGitHubRepositorySearch(term: String, page: Int) -> RequestResource {
        let searchEndpoint = "https://api.github.com/search/repositories"
        
        return RequestResource(httpMethod: .get,
                               endpoint: searchEndpoint,
                               queryItems: [URLQueryItem(name: "q", value: term),
                                            URLQueryItem(name: "page", value: "\(page)")])
    }
}
