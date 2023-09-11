//
//  GitHubRepoSearcherTests.swift
//  GitHubReposTests
//
//  Created by Zsuzsa Faskerti on 2023. 09. 11..
//

import XCTest

final class GitHubRepoSearcherTests: XCTestCase {
    
    var gitHubServicesMock: GitHubServicesMock!
    var searcher: DefaultGitHubRepoSearcher!
    
    override func setUp() {
        super.setUp()
        
        gitHubServicesMock = GitHubServicesMock()
        if gitHubServicesMock.reposMock.isEmpty {
            fatalError("❌ Test need repos in mock searcher.")
        }
        searcher = DefaultGitHubRepoSearcher(services: gitHubServicesMock)
    }
    
    override func tearDown() {
        gitHubServicesMock = nil
        searcher = nil
    }
    
    func test_whenRepositoriesAreFetched_shouldBeStored() {
        
        searcher.fetchRepositories { }
        XCTAssertEqual(searcher.repos.value, gitHubServicesMock.reposMock, "❌ New repos has not been stored.")
    }
    
    func test_whenMoreRepositoriesAreFetched_shouldBeStoredAfterOldOnes() {
        
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
        
        var completionCallCount = 0
        searcher.fetchRepositories {
            completionCallCount += 1
        }
        
        XCTAssertNotEqual(completionCallCount, 0, "❌ Completion is not called.")
        XCTAssertEqual(completionCallCount, 1, "❌ Completion is called more that once.")
    }
    
    func test_whenAsked_shouldUpdateSearchTerm() {

        let expectedSearchTerm = "❤️ Unit Tests"
        searcher.updateSearchTerm(expectedSearchTerm)
        
        let newSearchTerm = searcher.searchTerm
        XCTAssertEqual(newSearchTerm, expectedSearchTerm, "❌ searchTerm has not been updated.")
    }
    
    func test_whenCancelSearchAsked_shouldEmptyRepos() {
        
        searcher.fetchRepositories { }
        if searcher.repos.value != gitHubServicesMock.reposMock {
            fatalError("❌ New repos need to be stored for test.")
        }
        
        searcher.cancelSearch()
        XCTAssertTrue(searcher.repos.value.isEmpty, "❌ Cancel search did not empty repos.")
    }
    
    func test_whenCancelSearchAsked_shouldEmptySearchTerm() {
        
        searcher.updateSearchTerm("❤️ Unit Tests")
        if searcher.searchTerm == "" {
            fatalError("❌ Test needs text in searchTerm.")
        }
        
        searcher.cancelSearch()
        XCTAssertTrue(searcher.searchTerm == "", "❌ Cancel search did not empty searchTerm.")
    }
}
