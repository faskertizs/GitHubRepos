//
//  ApplicationCoordinator.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 10..
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController = UINavigationController()
    
    let viewModelProvider: ViewModelProvider
    
    init(viewModelProvider: ViewModelProvider) {
        self.viewModelProvider = viewModelProvider
    }
    
    func start() {
        let reposCoordinator = ReposCoordinator(navigationController: navigationController, viewModelProvider: viewModelProvider)
        children = [reposCoordinator]
        reposCoordinator.start()
    }
}
