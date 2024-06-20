//
//  Character.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

struct Character {
    let uuid: UUID
    let id: Int
    let name: String
    var description: String
    let thumbnailURL: String
    var isFavorite: Bool
    var image: UIImage?
    var firstAdditionalContent: [AdditionalContent]?
    var secondAdditionalContent: [AdditionalContent]?
}

// MARK: - Extension DescriptableProtocol
extension Character: DescriptableProtocol {
    var title: String {
        name
    }
    
    init(with cdo: DescriptableProtocolCDO) {
        uuid = cdo.uuid
        id = Int(cdo.contentID)
        name = cdo.title
        description = cdo.descriptionText
        thumbnailURL = cdo.thumbnailURL
        isFavorite = cdo.isFavorite
        firstAdditionalContent = cdo.firstAdditionalContent?.map { .init(with: $0) }
        secondAdditionalContent = cdo.secondAdditionalContent?.map { .init(with: $0) }
        
        guard let imageData = cdo.imageData else { return }
        image = UIImage(data: imageData)
    }
}

// MARK: - Extension Initialization With DTO
extension Character {
    init(with dto: CharacterDTO) {
        uuid = UUID()
        isFavorite = false
        id = dto.id
        name = dto.name
        description = dto.description
        thumbnailURL = dto.thumbnail.url
    }
}
