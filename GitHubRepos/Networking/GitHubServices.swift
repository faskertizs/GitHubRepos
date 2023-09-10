//
//  GitHubServices.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

protocol GitHubServices {
    func repositories(with term: String, completion: @escaping ([GitHubRepo]) -> Void)
    func imageData(for urlString: String, completion: @escaping (Data) -> Void)
}
