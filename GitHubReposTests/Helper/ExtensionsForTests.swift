//
//  ExtensionsForTests.swift
//  GitHubReposTests
//
//  Created by Zsuzsa Faskerti on 2023. 09. 09..
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

extension GitHubSearchResult {
    enum GitHubSearchResultError: Error {
        case decodingFailure
    }
    
    static func mock() throws -> GitHubSearchResult {
        let data = Data.loadJSON(fileName: "SearchReposResponseDataMock",
                                 in: Bundle(for: GitHubSearchResultDecoderTests.self))
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let searchResult = try decoder.decode(GitHubSearchResult.self, from: data)
            return searchResult
        } catch {
            throw GitHubSearchResultError.decodingFailure
        }
    }
}

extension GitHubRepo: Equatable {
    static func == (lhs: GitHubRepo, rhs: GitHubRepo) -> Bool {
        return (lhs.name == rhs.name &&
                lhs.description == rhs.description &&
                lhs.language == rhs.language &&
                lhs.htmlUrl == rhs.htmlUrl &&
                lhs.stargazersCount == rhs.stargazersCount &&
                lhs.owner == rhs.owner)
    }
}

extension GitHubRepo.RepoOwner: Equatable {
    static func == (lhs: GitHubRepo.RepoOwner, rhs: GitHubRepo.RepoOwner) -> Bool {
        return (lhs.login == rhs.login &&
                lhs.avatarUrl == rhs.avatarUrl)
    }
}
