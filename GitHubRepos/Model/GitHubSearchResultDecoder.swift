//
//  GitHubSearchResultDecoder.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

struct GitHubSearchResultDecoder {
    
    func decode(from data: Data) throws -> GitHubSearchResult {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let searchResult = try decoder.decode(GitHubSearchResult.self, from: data)
            return searchResult
        } catch {
            throw error
        }
        
    }
}
