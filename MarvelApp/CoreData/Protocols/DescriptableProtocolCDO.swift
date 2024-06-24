//
//  DescriptableProtocolCDO.swift
//  MarvelApp
//
//  Created by Rafis on 15.06.2024.
//

import Foundation

protocol DescriptableProtocolCDO {
    var descriptionText: String { get set }
    var imageData: Data? { get set }
    var isFavorite: Bool { get set }
    var thumbnailURL: String { get set }
    var title: String { get set }
    var uuid: UUID { get set }
    var contentID: Int64 { get set }
    var firstAdditionalContent: Set<AdditionalContentCDO>? { get set }
    var secondAdditionalContent: Set<AdditionalContentCDO>? { get set }
}
