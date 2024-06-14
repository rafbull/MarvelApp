//
//  ContentListAssembly.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class ContentListAssembly {
    struct Parameters {
        let contentType: ContentType
    }
    
    struct Dependencies {
        let navigationController: UINavigationController
        let networkService: NetworkServiceProtocol
    }
    
    static func makeModule(with dependecies: Dependencies, and parameters: Parameters) -> UIViewController {
        let router = ContentListRouter(navigationController: dependecies.navigationController)
        let presenter = ContentListPresenter(contentType: parameters.contentType, router: router, networkService: dependecies.networkService)
        let viewController = ContentListViewController(presenter: presenter)
        
        return viewController
    }
}
