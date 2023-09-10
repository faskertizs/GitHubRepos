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
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let reposCoordinator = ReposCoordinator(navigationController: navigationController)
        children = [reposCoordinator]
        reposCoordinator.start()
    }
}
