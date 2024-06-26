//
//  ContentDetailRouter.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class ContentDetailRouter {
    // MARK: - Private Properties
    private let navigationController: UINavigationController
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal Methods
    func showContentDetailViewController(
        for contentType: ContentType,
        with contentID: Int,
        coreDataService: CoreDataServiceProtocol,
        networkService: NetworkServiceProtocol
    ) {
        let dependencies = ContentDetailAssembly.Dependencies(
            navigationController: navigationController,
            coreDataService: coreDataService,
            networkService: networkService
        )
        let parameters = ContentDetailAssembly.Parameters(contentType: contentType, contentID: contentID)
        let contentDetailViewController = ContentDetailAssembly.makeModule(with: dependencies, and: parameters)
        
        navigationController.pushViewController(contentDetailViewController, animated: true)
    }
    
    func showAlertController() {
        let alertController = AlertControllerFabric.createAlerController(
            title: AppConstant.alertTitle,
            message: AppConstant.alertMessage,
            actionTitle: AppConstant.alertActionTitle
        )
        
        navigationController.present(alertController, animated: true)
    }
}
