//
//  ContentDetailAssembly.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class ContentDetailAssembly {
    struct Parameters {
        let contentType: ContentType
        let contentID: Int
    }
    
    struct Dependencies {
        let navigationController: UINavigationController
        let coreDataService: CoreDataServiceProtocol
        let networkService: NetworkServiceProtocol
    }
    
    static func makeModule(with dependecies: Dependencies, and parameters: Parameters) -> UIViewController {
        let router = ContentDetailRouter(navigationController: dependecies.navigationController)
        let presenter = ContentDetailPresenter(
            contentType: parameters.contentType,
            contentID: parameters.contentID,
            router: router,
            coreDataService: dependecies.coreDataService,
            networkService: dependecies.networkService
        )
        let viewController = ContentDetailViewController(presenter: presenter)
        
        return viewController
    }
}
