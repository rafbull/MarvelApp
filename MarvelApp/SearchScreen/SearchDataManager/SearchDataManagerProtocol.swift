//
//  SearchDataManagerProtocol.swift
//  MarvelApp
//
//  Created by Rafis on 14.06.2024.
//

import Foundation

protocol SearchDataManagerProtocol {
    func loadData(completion: @escaping (Result<[SearchContentDTO], Error>) -> Void)
}
