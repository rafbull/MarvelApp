//
//  Event.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import UIKit

struct Event {
    let uuid: UUID
    let id: Int
    let title: String
    let thumbnailURL: String
    var description: String
    var isFavorite: Bool
    var image: UIImage?
    var firstAdditionalContent: [AdditionalContent]?
    var secondAdditionalContent: [AdditionalContent]?
}

// MARK: - Extension DescriptableProtocol
extension Event: DescriptableProtocol {
    init(with cdo: DescriptableProtocolCDO) {
        uuid = cdo.uuid
        id = Int(cdo.contentID)
        title = cdo.title
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
extension Event {
    init(with dto: EventDTO) {
        uuid = UUID()
        isFavorite = false
        id = dto.id
        title = dto.title
        thumbnailURL = dto.thumbnail.url
        description = dto.description
    }
}
