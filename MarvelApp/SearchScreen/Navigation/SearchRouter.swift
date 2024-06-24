//
//  SearchRouter.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class SearchRouter {
    // MARK: - Private Properties
    private let navigationController: UINavigationController
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal Methods
    func showContentListViewController(
        with contentType: ContentType,
        coreDataService: CoreDataServiceProtocol,
        networkService: NetworkServiceProtocol
    ) {
        let parameters = ContentListAssembly.Parameters(contentType: contentType)
        let dependencies = ContentListAssembly.Dependencies(
            navigationController: navigationController,
            coreDataService: coreDataService,
            networkService: networkService
        )
        let contentListViewControler = ContentListAssembly.makeModule(with: dependencies, and: parameters)
        
        navigationController.pushViewController(contentListViewControler, animated: true)
    }
    
    func showContentDetailViewController(
        for contenType: ContentType,
        with contentID: Int,
        coreDataService: CoreDataServiceProtocol,
        networkService: NetworkServiceProtocol
    ) {
        let dependencies = ContentDetailAssembly.Dependencies(
            navigationController: navigationController,
            coreDataService: coreDataService,
            networkService: networkService
        )
        let parameters = ContentDetailAssembly.Parameters(contentType: contenType, contentID: contentID)
        let contentDetailViewController = ContentDetailAssembly.makeModule(with: dependencies, and: parameters)
        
        navigationController.pushViewController(contentDetailViewController, animated: true)
    }
}
