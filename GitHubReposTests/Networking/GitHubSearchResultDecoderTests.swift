//
//  GitHubSearchResultDecoderTests.swift
//  GitHubReposTests
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import XCTest

final class GitHubSearchResultDecoderTests: XCTestCase {

    let data = Data.loadJSON(fileName: "SearchReposResponseDataMock",
                             in: Bundle(for: GitHubSearchResultDecoderTests.self))

    func test_decoder_shouldDecodeJSONResponse() {
        XCTAssertNoThrow(try JSONDecoder().decodeSearchResultFromSnakeCase(from: data))
    }
    
    func test_decoder_shouldParseUnderScoredKeys() {
        let searchResult = try? JSONDecoder().decodeSearchResultFromSnakeCase(from: data)
        XCTAssertNotNil(searchResult?.items.first?.htmlUrl)
    }
}
