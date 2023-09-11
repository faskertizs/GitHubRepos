//
//  NetworkManagerProtocol.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

protocol NetworkManagerProtocol {
    func performRequest(_ request: URLRequest, completion: @escaping (Result<Data, NetworkingError>) -> Void)
    func loadData(from url: URL, completion: @escaping (Result<Data, NetworkingError>) -> Void)
}
