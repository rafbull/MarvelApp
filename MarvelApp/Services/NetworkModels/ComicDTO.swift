//
//  ComicDTO.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

struct ComicDTO: Decodable {
    let id: Int
    let digitalId: Int
    let title: String
    let variantDescription: String
    let modified: String
    let isbn: String
    let upc: String
    let diamondCode: String
    let ean: String
    let issn: String
    let format: String
    let pageCount: Int
//    let textObjects: [TextObject]
//    let series: SeriesDTO
//    let variants: [SeriesDTO]
//    let collections: [SeriesDTO]
//    let collectedIssues: [SeriesDTO]
    
    let thumbnail: ThumbnailDTO
    
//    let images: [ThumbnailDTO]
//    let creators: CreatorDTO
//    let characters: CharacterDTO
//    let stories: StoryDTO
//    let events: CharacterDTO
    
}
