//
//  SeriesDTO.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import Foundation

struct Series {
    let id: Int
    let optionalTitle: String?
    let optionalDescription: String?
    let thumbnailURL: String
    
    //    let creators: CreatorDTO
    //    let characters: CharacterDTO
    //    let stories: StoryDTO
    //    let comics: ComicDTO
    //    let events: EventDTO
}

// MARK: - Extension Initialization
extension Series {
    init(with dto: SeriesDTO) {
        id = dto.id
        optionalTitle = dto.title
        optionalDescription = dto.description
        thumbnailURL = dto.thumbnail.url
    }
}

// MARK: - Extension Descriptable
extension Series: Descriptable {
    var title: String {
        optionalTitle ?? ""
    }
    
    var description: String {
        optionalDescription ?? ""
    }
    
}
