//
//  GitHubSearchResult.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

struct GitHubSearchResult: Decodable {
    var items: [GitHubRepo]
}
