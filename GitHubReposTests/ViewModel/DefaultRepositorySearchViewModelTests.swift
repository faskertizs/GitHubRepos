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
        XCTAssertEqual(viewModel.repos, gitHubServicesMock.reposMock, "❌ New repos are not stored")
    }
}
