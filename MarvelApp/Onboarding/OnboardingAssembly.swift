//
//  OnboardingAssembly.swift
//  MarvelApp
//
//  Created by Rafis on 20.06.2024.
//

import UIKit

final class OnboardingAssembly {
    struct Dependencies {
        let dataManager: OnboardingDataManagerProtocol
    }
    
    struct Parameters {
        let hasSeenOnboarding: Observable<Bool>
    }
    
    static func makeModule(with dependecies: Dependencies, and parameters: Parameters) -> UIViewController {
        let presenter = OnboardingPresenter(
            dataManager: dependecies.dataManager,
            hasSeenOnboarding: parameters.hasSeenOnboarding
        )
        let viewController = OnboardingPageViewController(presenter: presenter)
        return viewController
    }
}
