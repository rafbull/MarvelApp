//
//  Series.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import UIKit

struct Series {
    let uuid: UUID
    let id: Int
    let optionalTitle: String?
    let optionalDescription: String?
    let thumbnailURL: String
    var description: String
    var isFavorite: Bool
    var image: UIImage?
    var firstAdditionalContent: [AdditionalContent]?
    var secondAdditionalContent: [AdditionalContent]?
}

// MARK: - Extension DescriptableProtocol
extension Series: DescriptableProtocol {
    var title: String {
        optionalTitle ?? ""
    }
    
    init(with cdo: DescriptableProtocolCDO) {
        uuid = cdo.uuid
        id = Int(cdo.contentID)
        optionalTitle = cdo.title
        optionalDescription = cdo.descriptionText
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
extension Series {
    init(with dto: SeriesDTO) {
        uuid = UUID()
        isFavorite = false
        id = dto.id
        optionalTitle = dto.title
        optionalDescription = dto.description
        description = dto.description ?? ""
        thumbnailURL = dto.thumbnail.url
    }
}
