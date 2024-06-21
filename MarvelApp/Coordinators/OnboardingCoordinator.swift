//
//  OnboardingCoordinator.swift
//  MarvelApp
//
//  Created by Rafis on 21.06.2024.
//

import UIKit

final class OnboardingCoordinator: CoordinatorProtocol {
    // MARK: - Internal Properties
    private(set) var rootViewController = UIViewController()
    
    // MARK: - Private Properties
    private let hasSeenOnboarding: Observable<Bool>
    
    // MARK: - Initialization
    init(_ hasSeenOnboarding: Observable<Bool>) {
        self.hasSeenOnboarding = hasSeenOnboarding
    }
    
    // MARK: - Internal Methods
    func start() {
        let onboardingDataManager = OnboardingDataManager()
        let onboardingDependencies = OnboardingAssembly.Dependencies(dataManager: onboardingDataManager)
        let onboardingParameters = OnboardingAssembly.Parameters(hasSeenOnboarding: hasSeenOnboarding)
        let onboardingViewController = OnboardingAssembly.makeModule(
            with: onboardingDependencies,
            and: onboardingParameters
        )
        
        rootViewController = onboardingViewController
    }
}
