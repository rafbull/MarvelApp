//
//  TabBarController.swift
//  MarvelApp
//
//  Created by Rafis on 11.06.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Private Properties
    private let homeViewController: UIViewController
    private let searchViewController: UIViewController
    private let libraryViewController: UIViewController
    
    // MARK: - Initialization
    init(
        _ homeViewController: UIViewController,
        _ searchViewController: UIViewController,
        _ libraryViewController: UIViewController
    ) {
        self.homeViewController = homeViewController
        self.searchViewController = searchViewController
        self.libraryViewController = libraryViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}

// MARK: - Private Extension
private extension TabBarController {
    func setupTabBarController() {
        view.backgroundColor = .systemBackground
        tabBar.tintColor = AppColor.textColor
        
        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        searchViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        libraryViewController.tabBarItem.image = UIImage(systemName: "square.stack.3d.up")
        
        setViewControllers([homeViewController, searchViewController, libraryViewController], animated: true)
    }
}
