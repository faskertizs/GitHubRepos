//
//  AppStarter.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 11..
//

import Foundation
import UIKit

// OMG! This is a horrible name for the class. Needs to be renamed, but currently I do not have a better idea. :S
class AppStarter {
    let model: GitHubRepoSearcher
    let coordinator: Coordinator

    init() {
        model = DefaultGitHubRepoSearcher()
        coordinator = ApplicationCoordinator(viewModelProvider: ViewModelProvider(model: model))
    }
    
    func start() {
        coordinator.start()
    }
}
