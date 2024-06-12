//
//  FetchError.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

enum FetchError: Error {
    case badURL
    case requestFailed(Error)
    case redirection(statusCode: Int)
    case clientError(statusCode: Int, message: String)
    case serverError(statusCode: Int, message: String)
    case noData
    case decodingFailed(Error)
}
