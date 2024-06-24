//
//  OnboardingPresenter.swift
//  MarvelApp
//
//  Created by Rafis on 20.06.2024.
//

import Foundation

final class OnboardingPresenter {
    // MARK: - Private Properties
    private let dataManager: OnboardingDataManagerProtocol
    private let hasSeenOnboarding: Observable<Bool>
    private var viewModels = [OnboardingViewModel]()
    private weak var ui: OnboardingViewProtocol?
    
    // MARK: - Initialization
    init(dataManager: OnboardingDataManagerProtocol, hasSeenOnboarding: Observable<Bool>) {
        self.dataManager = dataManager
        self.hasSeenOnboarding = hasSeenOnboarding
    }
    
    // MARK: - Internal Methods
    func didLoad(ui: OnboardingViewProtocol) {
        self.ui = ui
        loadData()
    }
    
    func didChangePage(index: Int) {
        ui?.setPageControlCurrentPage(with: index)
    }
    
    func didTapStartExploringButton() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.isLaunchedBefore.rawValue)
        hasSeenOnboarding.value = true
    }
}

// MARK: - Private Extension
private extension OnboardingPresenter {
    func loadData() {
        dataManager.loadData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                break
            case .success(let onboardingContentDTOArray):
                self.viewModels = onboardingContentDTOArray.map { .init(with: $0) }
                self.ui?.setDataSourceAndDelegate()
                self.ui?.setOnboardingViewControllers(with: self.viewModels, initialPage: 0)
            }
        }
    }
}
