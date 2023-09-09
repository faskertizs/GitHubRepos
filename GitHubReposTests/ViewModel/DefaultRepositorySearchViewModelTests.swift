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
        
        let viewModel = DefaultRepositorySearchViewModel(gitHubServices: GitHubServicesMock())
        viewModel.fetchRepositories()
        XCTAssertEqual(viewModel.repos.value, gitHubServicesMock.reposMock, "❌ New repos has not been stored.")
    }
    
    func test_whenAsked_shouldUpdateSearchTerm() {
        let viewModel = DefaultRepositorySearchViewModel(gitHubServices: GitHubServicesMock())
        let expectedSearchTerm = "newSearchTerm"
        
        viewModel.updateSearchTerm(expectedSearchTerm)
        let newSearchTerm = viewModel.searchTerm
        XCTAssertEqual(newSearchTerm, expectedSearchTerm, "❌ searchTerm has not been updated.")
    }
}
