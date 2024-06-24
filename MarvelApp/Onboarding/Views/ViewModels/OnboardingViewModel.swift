//
//  OnboardingViewModel.swift
//  MarvelApp
//
//  Created by Rafis on 20.06.2024.
//

import Foundation

struct OnboardingViewModel {
    let imageName: String
    let labelText: String
}

// MARK: - Extension Initialization With DTO
extension OnboardingViewModel {
    init(with dto: OnboardingContentDTO) {
        imageName = dto.imageName
        labelText = dto.labelText
    }
}
