//
//  AdditionalContent.swift
//  MarvelApp
//
//  Created by Rafis on 15.06.2024.
//

import UIKit

struct AdditionalContent {
    let id: Int
    let title: String
    var image: UIImage?
}

// MARK: - Extension Initialization With CDO
extension AdditionalContent {
    init(with cdo: AdditionalContentCDO) {
        id = Int(cdo.contentID)
        title = cdo.title
        guard let imageData = cdo.imageData else { return }
        image = UIImage(data: imageData)
    }
}

// MARK: - Extension Initialization With DescriptableProtocol
extension AdditionalContent {
    init(with descriptionObject: DescriptableProtocol) {
        id = descriptionObject.id
        title = descriptionObject.title
        image = descriptionObject.image
    }
}
