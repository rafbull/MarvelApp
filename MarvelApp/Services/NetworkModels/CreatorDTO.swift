//
//  CreatorDTO.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import Foundation

struct CreatorDTO: Decodable {
    let id: Int
    let fullName: String
    let thumbnail: ThumbnailDTO
}
