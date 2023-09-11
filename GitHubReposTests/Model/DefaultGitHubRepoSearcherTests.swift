//
//  GitHubRepoSearcherTests.swift
//  GitHubReposTests
//
//  Created by Zsuzsa Faskerti on 2023. 09. 11..
//

import XCTest

final class GitHubRepoSearcherTests: XCTestCase {
    
    func test_whenRepositoriesAreFetched_shouldBeStored() {
        
        let gitHubServicesMock = GitHubServicesMock()
        XCTAssertNotNil(gitHubServicesMock.reposMock.first, "❌ repos in mock is empty.")
        
        let searcher = DefaultGitHubRepoSearcher(services: gitHubServicesMock)
        searcher.fetchRepositories { }
        XCTAssertEqual(searcher.repos.value, gitHubServicesMock.reposMock, "❌ New repos has not been stored.")
    }
    
    func test_whenAsked_shouldUpdateSearchTerm() {
        let gitHubServicesMock = GitHubServicesMock()
        let searcher = DefaultGitHubRepoSearcher(services: gitHubServicesMock)
        let expectedSearchTerm = "newSearchTerm"
        
        searcher.updateSearchTerm(expectedSearchTerm)
        let newSearchTerm = searcher.searchTerm
        XCTAssertEqual(newSearchTerm, expectedSearchTerm, "❌ searchTerm has not been updated.")
    }
    
    func test_whenMoreRepositoriesAreFetched_shouldBeStoredProperly() {
        
        let gitHubServicesMock = GitHubServicesMock()
        XCTAssertNotNil(gitHubServicesMock.reposMock.first, "❌ repos in mock is empty.")
        
        let searcher = DefaultGitHubRepoSearcher(services: gitHubServicesMock)
        
        let firstIndexOfNewRepos = searcher.repos.value.count
        let newReposCount = gitHubServicesMock.reposMock.count
        
        searcher.fetchMoreRepositories { }
        
        var message = ""
        var reposAreAdded = true
        
        for index in 0..<newReposCount {
            let newIndex = firstIndexOfNewRepos + index
            if searcher.repos.value.count < newIndex {
                reposAreAdded = false
                message = "❌ Count of repos did not increase."
                break
            }
            if searcher.repos.value[newIndex] != gitHubServicesMock.reposMock[index] {
                reposAreAdded = false
                message = "❌ New repos was not added to 'repos' properly."
                break
            }
        }
        
        XCTAssertTrue(reposAreAdded, message)
    }
    
    func test_whenRepositoriesAreFetched_completionShouldBeCalledOnce() {
        
        let gitHubServicesMock = GitHubServicesMock()
        XCTAssertNotNil(gitHubServicesMock.reposMock.first, "❌ repos in mock is empty.")
        
        let searcher = DefaultGitHubRepoSearcher(services: gitHubServicesMock)
        
        var completionCallCount = 0
        searcher.fetchRepositories {
            completionCallCount += 1
        }
        XCTAssertNotEqual(completionCallCount, 0, "❌ Completion is not called.")
        XCTAssertEqual(completionCallCount, 1, "❌ Completion is called more that once.")
    }
    
    func test_whenMoreRepositoriesAreFetched_completionShouldBeCalledOnce() {
        
        let gitHubServicesMock = GitHubServicesMock()
        XCTAssertNotNil(gitHubServicesMock.reposMock.first, "❌ repos in mock is empty.")
        
        let searcher = DefaultGitHubRepoSearcher(services: gitHubServicesMock)
        
        var completionCallCount = 0
        searcher.fetchMoreRepositories {
            completionCallCount += 1
        }
        XCTAssertNotEqual(completionCallCount, 0, "❌ Completion is not called.")
        XCTAssertEqual(completionCallCount, 1, "❌ Completion is called more that once.")
    }

}
