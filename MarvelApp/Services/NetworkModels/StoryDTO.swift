//
//  StoryDTO.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import Foundation

struct StoryDTO: Decodable {
    let id: Int
    let title: String
    let description: String
//    let resourceURI: String
//    let type: String
    let modified: String
    let thumbnail: ThumbnailDTO?
}
