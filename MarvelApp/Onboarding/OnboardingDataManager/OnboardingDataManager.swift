//
//  OnboardingDataManager.swift
//  MarvelApp
//
//  Created by Rafis on 21.06.2024.
//

import Foundation

final class OnboardingDataManager: OnboardingDataManagerProtocol {
    // MARK: - Internal Methods
    func loadData(completion: @escaping (Result<[OnboardingContentDTO], Error>) -> Void) {
        getOnboardingContentViewModels { onboardingContentDTOArray in
            completion(onboardingContentDTOArray)
        }
    }
}

// MARK: - Private Extension
private extension OnboardingDataManager {
    func getOnboardingContentViewModels(completion: @escaping (Result<[OnboardingContentDTO], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "OnboardingContentData", withExtension: "json")
        else {
            completion(.failure(FetchError.badURL))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let onboardingContentDTOArray = try JSONDecoder().decode([OnboardingContentDTO].self, from: data)
            completion(.success(onboardingContentDTOArray))
        } catch {
            completion(.failure(FetchError.decodingFailed(error)))
        }
    }
}
