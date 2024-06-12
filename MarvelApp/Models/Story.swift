//
//  StoryDTO.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import Foundation

struct Story {
    let id: Int
    let title: String
    let description: String
//    let resourceURI: String
//    let type: String
    let modified: String
    let thumbnailURL: String?
}

extension Story {
    init(with dto: StoryDTO) {
        id = dto.id
        title = dto.title
        description = dto.description
        modified = dto.modified
        thumbnailURL = dto.thumbnail?.url
    }
}
