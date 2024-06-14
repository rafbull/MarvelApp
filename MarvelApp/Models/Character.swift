//
//  CharacterDTO.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

struct Character {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnailURL: String
    let resourceURI: String

//    let comics: Comics
//    let series: Comics
//    let stories: Stories
//    let events: Comics
//    let urls: [URLElement]

}

// MARK: - Extension Initialization
extension Character {
    init(with dto: CharacterDTO) {
        id = dto.id
        name = dto.name
        description = dto.description
        modified = dto.modified
        thumbnailURL = dto.thumbnail.url
        resourceURI = dto.resourceURI
    }
}

// MARK: - Extension Descriptable
extension Character: Descriptable {
    var title: String {
        name
    }
}
