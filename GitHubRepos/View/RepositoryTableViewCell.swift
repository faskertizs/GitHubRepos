//
//  RepositoryTableViewCell.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 10..
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    var viewModel: RepositoryViewModel?
    
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var starCountLabel: UILabel!
    
    override func prepareForReuse() {
        updateCellWith(repoName: "",
                       ownerName: "",
                       description:"",
                       language: "",
                       starCount:0)
    }
    
    func configure(with viewModel: RepositoryViewModel) {
        self.viewModel = viewModel
        let repo = viewModel.repo
        updateCellWith(repoName: repo.name ?? "",
                       ownerName: repo.ownerName ?? "",
                       description: repo.description ?? "",
                       language: repo.language ?? "",
                       starCount: repo.stargazersCount ?? 0)
        descriptionLabel.sizeToFit()
        if starImageView.image == nil {
            starImageView.image = UIImage(systemName: "star")
        }
    }

    private func updateCellWith(repoName: String,
                                ownerName: String,
                                description: String,
                                language: String,
                                starCount: Int) {
        repoNameLabel.text = repoName
        ownerNameLabel.text = ownerName
        descriptionLabel.text = description
        languageLabel.text = language
        starCountLabel.text = "\(starCount)"
    }
}
