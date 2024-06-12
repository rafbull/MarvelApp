//
//  EventDTO.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import Foundation

struct Event {
    let id: Int
    let title: String
    let description: String
//    let resourceURI: String
//    let urls: [URLElement]
    let modified: String
    let start: String?
    let end: String?
    let thumbnailURL: String
//    let creators: CreatorDTO
//    let characters: CharacterDTO
//    let stories: StoryDTO
//    let comics: ComicDTO
//    let series: SeriesDTO
//    let next: Next?
//    let previous: Next?
}

extension Event {
    init(with dto: EventDTO) {
        id = dto.id
        title = dto.title
        description = dto.description
        modified = dto.modified
        start = dto.start
        end = dto.end
        thumbnailURL = dto.thumbnail.url
    }
}
