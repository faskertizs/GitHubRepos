//
//  NetworkingError.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

enum NetworkingError: Error {
    case invalidResponse
    case invalidUrl
    case other(Error)
}
