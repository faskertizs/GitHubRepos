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
    
    var viewModelProvider: ViewModelProvider
    
    init(navigationController: UINavigationController, viewModelProvider: ViewModelProvider) {
        self.navigationController = navigationController
        self.viewModelProvider = viewModelProvider
    }
    
    func start() {
        let viewModel = viewModelProvider.makeRepositorySearchViewModel()
        let repositorySearchVC = RepositorySearchViewController(viewModel: viewModel)
        repositorySearchVC.coordinator = self
                
        navigationController.pushViewController(repositorySearchVC, animated: false)
    }
    
    func repoDetailsRequested(with urlString: String) {
        let vc = WebViewController(urlString: urlString)
        navigationController.pushViewController(vc, animated: true)
    }
}
