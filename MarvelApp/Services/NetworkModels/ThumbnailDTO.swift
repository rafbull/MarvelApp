//
//  ThumbnailDTO.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

struct ThumbnailDTO: Decodable {
    let path: String
    let thumbnailExtension: String
    
    var url: String {
        return "\(path).\(thumbnailExtension)"
    }

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
