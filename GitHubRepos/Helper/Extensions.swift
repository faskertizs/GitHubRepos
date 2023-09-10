//
//  Extensions.swift
//  GitHubRepos
//
//  Created by Zsuzsa Faskerti on 2023. 09. 08..
//

import Foundation
import UIKit

extension URLRequest {
    static func request(with resource: RequestResource) throws -> URLRequest {
        guard var components = URLComponents(string: resource.endpoint) else {
            throw NetworkingError.invalidUrl
        }
        components.queryItems = resource.queryItems
        
        guard let url = components.url else {
            throw NetworkingError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = resource.httpMethod.name
        return request
    }
}

// Source: https://gist.github.com/levibostian/7c659d632e633142bc8a0e5ad9ef6927
extension UITableView {
  func showLoadingFooter() {
    let spinner = UIActivityIndicatorView(style: .medium)
    spinner.startAnimating()
    spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.bounds.width, height: CGFloat(44))

    self.tableFooterView = spinner
    self.tableFooterView?.isHidden = false
}
  
  func hideLoadingFooter() {
    self.tableFooterView?.isHidden = true
    self.tableFooterView = nil
  }
}
