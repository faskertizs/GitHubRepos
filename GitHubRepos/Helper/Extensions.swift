//
//  Extensions.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

extension Data {
    static func loadJSON(fileName: String, in bundle: Bundle) -> Data {
        let fileExtension = ".json"
        guard let path = bundle.url(forResource: fileName, withExtension: fileExtension) else {
            fatalError("Failed to locate file in bundle: \(fileName + fileExtension)")
        }
        guard let data = try? Data(contentsOf: path) else {
            fatalError("Failed to load json from bundle: \(fileName + fileExtension)")
        }
        return data
    }
}

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
