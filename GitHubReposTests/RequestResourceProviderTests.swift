//
//  RequestResourceProviderTests.swift
//  GitHubReposTests
//
//  Created by Zsuzsa Faskerti on 2023. 09. 09..
//

import XCTest

final class RequestResourceProviderTests: XCTestCase {
    
    func test_searchRepositoriesHttpMethod_shouldBeProper() {
        let properHttpMethod = HttpMethod.get
        let provider = RequestResourceProvider.requestResourceForGitHubRepositorySearch(term: "searchTerm")
        XCTAssertEqual(provider.httpMethod, properHttpMethod)
    }
    
    func test_searchRepositoriesEndpoint_shouldBeProper() {
        let properEndpoint = "https://api.github.com/search/repositories"
        let provider = RequestResourceProvider.requestResourceForGitHubRepositorySearch(term: "searchTerm")
        XCTAssertEqual(provider.endpoint, properEndpoint)
    }
    
    func test_searchRepositoriesQueries_shouldContainSearchQuery() {
        let searchTerm = "test"
        let searchTermQueryItemName = "q"
        let provider = RequestResourceProvider.requestResourceForGitHubRepositorySearch(term: searchTerm)
        var searchQueryByProvider: URLQueryItem?
        
        for item in provider.queryItems {
            if item.name == searchTermQueryItemName {
                searchQueryByProvider = item
            }
        }
        
        XCTAssertNotNil(searchQueryByProvider)
        
        guard let value = searchQueryByProvider?.value else {
            XCTFail("Value for queryItem is nil for search reepositories.")
            return
        }
        XCTAssertEqual(value, searchTerm)
    }

}
