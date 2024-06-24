//
//  OnboardingDataManagerProtocol.swift
//  MarvelApp
//
//  Created by Rafis on 21.06.2024.
//

import Foundation

protocol OnboardingDataManagerProtocol {
    func loadData(completion: @escaping (Result<[OnboardingContentDTO], Error>) -> Void)
}
