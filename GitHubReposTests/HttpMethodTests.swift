//
//  HttpMethodTests.swift
//  GitHubReposTests
//
//  Created by Zsuzsa Faskerti on 2023. 09. 09..
//

import XCTest

final class HttpMethodTests: XCTestCase {

    func test_getMethodName_shouldBeGet() {
        let properNameForGetMethod = "GET"
        
        let httpGetMethod = HttpMethod.get
        
        XCTAssertEqual(httpGetMethod.name, properNameForGetMethod)
    }
}
