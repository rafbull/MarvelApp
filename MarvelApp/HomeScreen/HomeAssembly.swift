//
//  HomeAssembly.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import UIKit

final class HomeAssembly {
    struct Dependencies {
        let navigationController: UINavigationController
        let coreDataService: CoreDataServiceProtocol
        let networkService: NetworkServiceProtocol
    }
    
    static func makeModule(with dependecies: Dependencies) -> UIViewController {
        let router = HomeRouter(navigationController: dependecies.navigationController)
        let presenter = HomePresenter(
            router: router,
            coreDataService: dependecies.coreDataService,
            networkService: dependecies.networkService
        )
        let viewController = HomeViewController(presenter: presenter)
        
        return viewController
    }
}
