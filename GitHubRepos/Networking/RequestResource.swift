//
//  RequestResource.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

struct RequestResource {
    private(set) var httpMethod: HttpMethod
    private(set) var endpoint: String
    private(set) var queryItems: [URLQueryItem]
}
