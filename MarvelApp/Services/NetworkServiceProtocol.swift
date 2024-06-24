//
//  NetworkServiceProtocol.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(from endpoint: Endpoint, completion: @escaping (Result<BaseResponseDTO<T>, Error>) -> Void)
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}
