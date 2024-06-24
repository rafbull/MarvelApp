//
//  CharacterDTO.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

struct CharacterDTO: Decodable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: ThumbnailDTO
}
