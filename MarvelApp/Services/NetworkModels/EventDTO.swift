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
//    let resourceURI: String
//    let urls: [URLElement]
    let modified: String
    let start: String?
    let end: String?
    let thumbnail: ThumbnailDTO
//    let creators: CreatorDTO
//    let characters: CharacterDTO
//    let stories: StoryDTO
//    let comics: ComicDTO
//    let series: SeriesDTO
//    let next: Next?
//    let previous: Next?
}
