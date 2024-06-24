//
//  AppCoordinator.swift
//  MarvelApp
//
//  Created by Rafis on 21.06.2024.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    // MARK: - Private Properties
    private let window: UIWindow
    private var childCoordinators = [CoordinatorProtocol]()
    private var hasSeenOnboarding = Observable(false)
    
    // MARK: - Initialization
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Internal Methods
    func start() {
        setupHasSeenOnboarding()
        
        hasSeenOnboarding.bind { [weak self] hasSeenOnboarding in
            guard let self = self, let hasSeenOnboarding = hasSeenOnboarding else { return }
            if hasSeenOnboarding {
                let appTabBarCoordinator = AppTabBarCoordinator()
                appTabBarCoordinator.start()
                self.childCoordinators = [appTabBarCoordinator]
                self.window.rootViewController = appTabBarCoordinator.rootViewController
            } else {
                let onboardingCoordinator = OnboardingCoordinator(self.hasSeenOnboarding)
                onboardingCoordinator.start()
                self.childCoordinators = [onboardingCoordinator]
                self.window.rootViewController = onboardingCoordinator.rootViewController
            }
        }
    }
}

// MARK: - Private Extension
private extension AppCoordinator {
    func setupHasSeenOnboarding() {
        hasSeenOnboarding.value = UserDefaults.standard.bool(forKey: UserDefaultsKey.isLaunchedBefore.rawValue)
    }
}
