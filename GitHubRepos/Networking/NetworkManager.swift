//
//  NetworkManager.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

protocol NetworkManager {
    func performRequest(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
}
