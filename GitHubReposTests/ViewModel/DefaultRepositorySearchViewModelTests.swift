//
//  DefaultRepositorySearchViewModelTests.swift
//  GitHubReposTests
//
//  Created by Zsuzsa Faskerti on 2023. 09. 09..
//

import XCTest

final class DefaultRepositorySearchViewModelTests: XCTestCase {

    func test_whenRepositoriesAreFetched_shouldBeStored() {
        
        let gitHubServicesMock = GitHubServicesMock()
        XCTAssertNotNil(gitHubServicesMock.reposMock.first, "❌ repos in mock is empty.")
        
        let viewModel = DefaultRepositorySearchViewModel(gitHubServices: gitHubServicesMock)
        viewModel.fetchRepositories { }
        XCTAssertEqual(viewModel.repos.value, gitHubServicesMock.reposMock, "❌ New repos has not been stored.")
    }
    
    func test_whenAsked_shouldUpdateSearchTerm() {
        let viewModel = DefaultRepositorySearchViewModel(gitHubServices: GitHubServicesMock())
        let expectedSearchTerm = "newSearchTerm"
        
        viewModel.updateSearchTerm(expectedSearchTerm)
        let newSearchTerm = viewModel.searchTerm
        XCTAssertEqual(newSearchTerm, expectedSearchTerm, "❌ searchTerm has not been updated.")
    }
    
    func test_whenMoreRepositoriesAreFetched_shouldBeStoredProperly() {
        
        let gitHubServicesMock = GitHubServicesMock()
        XCTAssertNotNil(gitHubServicesMock.reposMock.first, "❌ repos in mock is empty.")
        
        let viewModel = DefaultRepositorySearchViewModel(gitHubServices: gitHubServicesMock)
        
        let firstIndexOfNewRepos = viewModel.repos.value.count
        let newReposCount = gitHubServicesMock.reposMock.count
        
        viewModel.fetchMoreRepositories { }
        
        var message = ""
        var reposAreAdded = true
        
        for index in 0..<newReposCount {
            let newIndex = firstIndexOfNewRepos + index
            if viewModel.repos.value.count < newIndex {
                reposAreAdded = false
                message = "❌ Count of repos did not increase."
                break
            }
            if viewModel.repos.value[newIndex] != gitHubServicesMock.reposMock[index] {
                reposAreAdded = false
                message = "❌ New repos was not added to 'repos' properly."
                break
            }
        }
        
        XCTAssertTrue(reposAreAdded, message)
    }
    
    func test_whenRepositoriesAreFetched_completionShouldBeCalledOnce() {
        
        let viewModel = DefaultRepositorySearchViewModel(gitHubServices: GitHubServicesMock())
        
        var completionCallCount = 0
        viewModel.fetchRepositories {
            completionCallCount += 1
        }
        XCTAssertNotEqual(completionCallCount, 0, "❌ Completion is not called.")
        XCTAssertEqual(completionCallCount, 1, "❌ Completion is called more that once.")
    }
    
    func test_whenMoreRepositoriesAreFetched_completionShouldBeCalledOnce() {
        
        let viewModel = DefaultRepositorySearchViewModel(gitHubServices: GitHubServicesMock())
        
        var completionCallCount = 0
        viewModel.fetchMoreRepositories {
            completionCallCount += 1
        }
        XCTAssertNotEqual(completionCallCount, 0, "❌ Completion is not called.")
        XCTAssertEqual(completionCallCount, 1, "❌ Completion is called more that once.")
    }
}
