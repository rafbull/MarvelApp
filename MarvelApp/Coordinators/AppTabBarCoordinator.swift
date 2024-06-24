//
//  AppTabBarCoordinator.swift
//  MarvelApp
//
//  Created by Rafis on 21.06.2024.
//

import UIKit

final class AppTabBarCoordinator: CoordinatorProtocol {
    // MARK: - Internal Properties
    private(set) var rootViewController = UIViewController()
    
    // MARK: - Internal Methods
    func start() {
        rootViewController = createRootViewController()
    }
}

// MARK: - Private Extension
private extension AppTabBarCoordinator {
    func createRootViewController() -> UIViewController {
        let networkService = NetworkService()
        let coreDataService = CoreDataService()
        
        let homeNavigationController = UINavigationController()
        let homeDependencies = HomeAssembly.Dependencies(navigationController: homeNavigationController, coreDataService: coreDataService, networkService: networkService)
        let homeViewController = HomeAssembly.makeModule(with: homeDependencies)
        homeNavigationController.viewControllers = [homeViewController]
        
        let searchDataManager = SearchDataManager()
        let searchNavigationController = UINavigationController()
        let searchDependencies = SearchAssembly.Dependencies(navigationController: searchNavigationController, dataManager: searchDataManager, coreDataService: coreDataService, networkService: networkService)
        let searchViewController = SearchAssembly.makeModule(with: searchDependencies)
        searchNavigationController.viewControllers = [searchViewController]
        
        let libraryNavigationController = UINavigationController()
        let libraryDependencies = LibraryAssembly.Dependencies(navigationController: libraryNavigationController, coreDataService: coreDataService, networkService: networkService)
        let libraryViewController = LibraryAssembly.makeModule(with: libraryDependencies)
        libraryNavigationController.viewControllers = [libraryViewController]
        
        return TabBarController(
            homeNavigationController,
            searchNavigationController,
            libraryNavigationController
        )
    }
}
