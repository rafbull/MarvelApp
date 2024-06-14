//
//  Comic.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

struct Comic {
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
//    let series: Series
//    let variants: [Series]
//    let collections: [Series]
//    let collectedIssues: [Series]
    
    let thumbnailURL: String
    
//    let images: [Thumbnail]
//    let creators: Creators
//    let characters: Characters
//    let stories: Stories
//    let events: Characters
    
}

// MARK: - Extension Initialization
extension Comic {
    init(with dto: ComicDTO) {
        id = dto.id
        digitalId = dto.digitalId
        title = dto.title
        variantDescription = dto.variantDescription
        modified = dto.modified
        isbn = dto.isbn
        upc = dto.upc
        diamondCode = dto.diamondCode
        ean = dto.ean
        issn = dto.issn
        format = dto.format
        pageCount = dto.pageCount
        thumbnailURL = dto.thumbnail.url
    }
}

// MARK: - Extension Descriptable
extension Comic: Descriptable {
    var description: String {
        variantDescription
    }
}
