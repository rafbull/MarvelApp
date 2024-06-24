//
//  LibraryAssembly.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import UIKit

final class LibraryAssembly {
    struct Dependencies {
        let navigationController: UINavigationController
        let coreDataService: CoreDataServiceProtocol
        let networkService: NetworkServiceProtocol
    }
    
    static func makeModule(with dependecies: Dependencies) -> UIViewController {
        let router = LibraryRouter(navigationController: dependecies.navigationController)
        let presenter = LibraryPresenter(
            router: router,
            coreDataService: dependecies.coreDataService,
            networkService: dependecies.networkService
        )
        let viewController = LibraryViewController(presenter: presenter)
        
        return viewController
    }
}
