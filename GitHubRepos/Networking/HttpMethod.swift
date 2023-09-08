//
//  HttpMethod.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

enum HttpMethod {
    case get
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}
