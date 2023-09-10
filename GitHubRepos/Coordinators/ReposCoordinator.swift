//
//  ReposCoordinator.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 10..
//

import Foundation
import UIKit

class ReposCoordinator: Coordinator {
    var children = [Coordinator]()

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkManager = DefaultNetworkManager()
        let githubServices = DefaultGitHubServices(networkManager: networkManager)
        let viewModel = DefaultRepositorySearchViewModel(gitHubServices: githubServices)
        let repositorySearchVC = RepositorySearchViewController(viewModel: viewModel)
                
        navigationController.pushViewController(repositorySearchVC, animated: false)
    }
    
    
}
