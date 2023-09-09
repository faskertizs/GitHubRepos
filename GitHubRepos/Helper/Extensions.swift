//
//  Extensions.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

extension URLRequest {
    static func request(with resource: RequestResource) throws -> URLRequest {
        guard var components = URLComponents(string: resource.endpoint) else {
            throw NetworkingError.invalidUrl
        }
        components.queryItems = resource.queryItems
        
        guard let url = components.url else {
            throw NetworkingError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = resource.httpMethod.name
        return request
    }
}
