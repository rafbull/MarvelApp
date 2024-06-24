//
//  Creator.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import UIKit

struct Creator {
    let uuid: UUID
    let id: Int
    let fullName: String
    let thumbnailURL: String
    var description: String
    var isFavorite: Bool
    var image: UIImage?
    var firstAdditionalContent: [AdditionalContent]?
    var secondAdditionalContent: [AdditionalContent]?
}

// MARK: - Extension DescriptableProtocol
extension Creator: DescriptableProtocol {
    var title: String {
        fullName
    }
    
    init(with cdo: DescriptableProtocolCDO) {
        uuid = cdo.uuid
        id = Int(cdo.contentID)
        fullName = cdo.title
        thumbnailURL = cdo.thumbnailURL
        description = cdo.descriptionText
        isFavorite = cdo.isFavorite
        firstAdditionalContent = cdo.firstAdditionalContent?.map { .init(with: $0) }
        secondAdditionalContent = cdo.secondAdditionalContent?.map { .init(with: $0) }
        
        guard let imageData = cdo.imageData else { return }
        image = UIImage(data: imageData)
    }
}

// MARK: - Extension Initialization With DTO
extension Creator {
    init(with dto: CreatorDTO) {
        uuid = UUID()
        description = ""
        isFavorite = false
        id = dto.id
        fullName = dto.fullName
        thumbnailURL = dto.thumbnail.url
    }
}
