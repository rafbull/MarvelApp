//
//  CreatorDTO.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import Foundation

struct Creator {
    let id: Int
    let firstName: String
    let lastName: String
    let fullName: String
    let modified: String
    let thumbnailURL: String
    
//    let resourceURI: String
//    let comics: ComicDTO
//    let series: SeriesDTO
//    let stories: StoryDTO
//    let events: EventDTO
//    let urls: [URLElement]
}

extension Creator {
    init(with dto: CreatorDTO) {
        id = dto.id
        firstName = dto.firstName
        lastName = dto.lastName
        fullName = dto.fullName
        modified = dto.modified
        thumbnailURL = dto.thumbnail.url
    }
}
