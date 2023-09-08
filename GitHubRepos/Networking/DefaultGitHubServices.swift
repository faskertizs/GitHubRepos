//
//  DefaultGitHubServices.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation

class DefaultGitHubServices {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension DefaultGitHubServices: GitHubServices {
    func repositories(with term: String, completion: @escaping ([GitHubRepo]) -> Void) {
        let requestResource = RequestResourceProvider.requestResourceForGitHubRepositorySearch(term: term)
        var request: URLRequest
        do {
            request = try URLRequest.request(with: requestResource)
        } catch {
            print("❌ Search url is invalid.")
            return
        }
        
        networkManager.performRequest(request, completion: { result in
            switch result {
            case .success(let data):
                let decoder = GitHubSearchResultDecoder()
                guard let repos = try? decoder.decode(from: data) else {
                    print("❌ Parsing is failed.")
                    return
                }
                completion(repos.items)
            case .failure(let error):
                print("❌ \(error.localizedDescription)")
            }
        })
    }
}
