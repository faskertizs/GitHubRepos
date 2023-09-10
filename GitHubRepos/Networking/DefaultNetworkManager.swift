//
//  DefaultNetworkManager.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

class DefaultNetworkManager: NetworkManager {
    
    func performRequest(_ request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
    
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("❌ \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkingError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.invalidResponse))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
    func loadData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkingError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.invalidResponse))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }

}
