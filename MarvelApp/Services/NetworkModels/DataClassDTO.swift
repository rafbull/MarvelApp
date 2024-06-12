//
//  DataClassDTO.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

struct DataClassDTO<T: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}
