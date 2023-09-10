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
        let resource = RequestResourceProvider.requestResourceForGitHubRepositorySearch(term: "searchTerm", page: 1)
        XCTAssertEqual(resource.httpMethod, properHttpMethod)
    }
    
    func test_searchRepositoriesEndpoint_shouldBeProper() {
        let properEndpoint = "https://api.github.com/search/repositories"
        let provider = RequestResourceProvider.requestResourceForGitHubRepositorySearch(term: "searchTerm", page: 1)
        XCTAssertEqual(provider.endpoint, properEndpoint)
    }
    
    func test_searchRepositoriesQueries_shouldContainSearchQuery() {
        let searchTerm = "test"
        let provider = RequestResourceProvider.requestResourceForGitHubRepositorySearch(term: searchTerm, page: 1)
        var searchQueryByProvider: URLQueryItem?
        
        let searchTermQueryItemName = "q"
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
    
    func test_searchRepositoriesQueries_shouldContainPageQuery() {
        let searchTerm = "test"
        let pageNumber = 1
        let provider = RequestResourceProvider.requestResourceForGitHubRepositorySearch(term: searchTerm, page: pageNumber)
        var searchQueryByProvider: URLQueryItem?
        
        let searchTermQueryItemName = "page"
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
        XCTAssertEqual(value, "\(pageNumber)")
    }
}
