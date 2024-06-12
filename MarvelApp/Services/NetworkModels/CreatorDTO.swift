//
//  CreatorDTO.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import Foundation

struct CreatorDTO: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let fullName: String
    let modified: String
    let thumbnail: ThumbnailDTO
    
//    let resourceURI: String
//    let comics: ComicDTO
//    let series: SeriesDTO
//    let stories: StoryDTO
//    let events: EventDTO
//    let urls: [URLElement]
}
