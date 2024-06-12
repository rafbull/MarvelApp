//
//  SeriesDTO.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import Foundation

struct Series {
    let id: Int
    let title: String?
    let description: String?
    let thumbnailURL: String
    
    //    let creators: CreatorDTO
    //    let characters: CharacterDTO
    //    let stories: StoryDTO
    //    let comics: ComicDTO
    //    let events: EventDTO
}

extension Series {
    init(with dto: SeriesDTO) {
        id = dto.id
        title = dto.title
        description = dto.description
        thumbnailURL = dto.thumbnail.url
    }
}
