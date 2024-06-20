//
//  Comic.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

struct Comic {
    let uuid: UUID
    let id: Int
    let title: String
    let thumbnailURL: String
    var description: String
    var isFavorite: Bool
    var image: UIImage?
    var defaultDescripion: String?
    var textObject: String?
    var firstAdditionalContent: [AdditionalContent]?
    var secondAdditionalContent: [AdditionalContent]?
}

// MARK: - Extension DescriptableProtocol
extension Comic: DescriptableProtocol {
    init(with cdo: DescriptableProtocolCDO) {
        uuid = cdo.uuid
        id = Int(cdo.contentID)
        title = cdo.title
        thumbnailURL = cdo.thumbnailURL
        isFavorite = cdo.isFavorite
        description = cdo.descriptionText
        firstAdditionalContent = cdo.firstAdditionalContent?.map { .init(with: $0) }
        secondAdditionalContent = cdo.secondAdditionalContent?.map { .init(with: $0) }
        
        guard let imageData = cdo.imageData else { return }
        image = UIImage(data: imageData)
    }
}

// MARK: - Extension Initialization With DTO
extension Comic {
    init(with dto: ComicDTO) {
        uuid = UUID()
        isFavorite = false
        id = dto.id
        title = dto.title
        thumbnailURL = dto.thumbnail.url
        description = dto.textObjects.first?.text ?? ""
        defaultDescripion = dto.description
        textObject = dto.textObjects.first?.text
        
    }
}
