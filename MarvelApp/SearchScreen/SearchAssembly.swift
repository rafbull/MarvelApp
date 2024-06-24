//
//  SearchAssembly.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class SearchAssembly {
    struct Dependencies {
        let navigationController: UINavigationController
        let dataManager: SearchDataManagerProtocol
        let coreDataService: CoreDataServiceProtocol
        let networkService: NetworkServiceProtocol
    }
    
    static func makeModule(with dependecies: Dependencies) -> UIViewController {
        let router = SearchRouter(navigationController: dependecies.navigationController)
        let presenter = SearchPresenter(
            router: router,
            dataManager: dependecies.dataManager,
            coreDataService: dependecies.coreDataService,
            networkService: dependecies.networkService
        )
        let viewController = SearchViewController(presenter: presenter)
        
        return viewController
    }
}
