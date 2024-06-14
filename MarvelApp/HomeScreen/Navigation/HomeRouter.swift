//
//  HomeRouter.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

final class HomeRouter {
    // MARK: - Private Properties
    private let navigationController: UINavigationController
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal Methods
    func showContentDetailViewController(for contenType: ContentType, with contentID: Int, networkService: NetworkServiceProtocol) {
        let dependencies = ContentDetailAssembly.Dependencies(navigationController: navigationController, networkService: networkService)
        let parameters = ContentDetailAssembly.Parameters(contentType: contenType, contentID: contentID)
        let contentDetailViewController = ContentDetailAssembly.makeModule(with: dependencies, and: parameters)
        
        navigationController.pushViewController(contentDetailViewController, animated: true)
    }
}
