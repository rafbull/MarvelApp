//
//  OnboardingViewProtocol.swift
//  MarvelApp
//
//  Created by Rafis on 20.06.2024.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    func setOnboardingViewControllers(with viewModels: [OnboardingViewModel], initialPage: Int)
    func setDataSourceAndDelegate()
    func setPageControlCurrentPage(with index: Int)
}
