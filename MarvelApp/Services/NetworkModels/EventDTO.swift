//
//  EventDTO.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import Foundation

struct EventDTO: Decodable {
    let id: Int
    let title: String
    let description: String
    let thumbnail: ThumbnailDTO
}
