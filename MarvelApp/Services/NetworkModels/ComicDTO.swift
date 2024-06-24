//
//  ComicDTO.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

struct ComicDTO: Decodable {
    let id: Int
    let title: String
    let description: String?
    let textObjects: [TextObjectDTO]
    let thumbnail: ThumbnailDTO
}
