//
//  BaseResponseDTO.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

struct BaseResponseDTO<T: Decodable>: Decodable {
    let code: Int
    let status: String
    let data: DataClassDTO<T>
}
