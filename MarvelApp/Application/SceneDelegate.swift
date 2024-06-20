//
//  SceneDelegate.swift
//  MarvelApp
//
//  Created by Rafis on 08.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createRootViewController()
        window?.makeKeyAndVisible()
    }
}

// MARK: - Private Extension
private extension SceneDelegate {
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
