//
//  GitHubRepo.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation



struct GitHubRepo: Decodable {
    
    struct RepoOwner: Decodable {
        var login: String?
        var avatarUrl: String?
    }
    
    var name: String?
    var description: String?
    var language: String?
    var htmlUrl: String?
    var stargazersCount: Int?

    private var owner: RepoOwner?

    var ownerName: String? {
        owner?.login
    }
    var ownerImageUrlString: String? {
        owner?.avatarUrl
    }
}
