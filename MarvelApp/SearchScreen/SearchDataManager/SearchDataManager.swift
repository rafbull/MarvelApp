//
//  SearchDataManager.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import Foundation

final class SearchDataManager: SearchDataManagerProtocol {
    // MARK: - Internal Methods
    func loadData(completion: @escaping (Result<[SearchContentDTO], Error>) -> Void) {
        getSearchContentViewModels { searchContentDTOArray in
            completion(searchContentDTOArray)
        }
    }
}

// MARK: - Private Extension
private extension SearchDataManager {
    func getSearchContentViewModels(completion: @escaping (Result<[SearchContentDTO], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "SearchContentData", withExtension: "json")
        else {
            completion(.failure(FetchError.badURL))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let searchContentDTOArray = try JSONDecoder().decode([SearchContentDTO].self, from: data)
            completion(.success(searchContentDTOArray))
        } catch {
            completion(.failure(FetchError.decodingFailed(error)))
        }
    }
}
