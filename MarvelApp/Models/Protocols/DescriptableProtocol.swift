//
//  DescriptableProtocol.swift
//  MarvelApp
//
//  Created by Rafis on 14.06.2024.
//

import UIKit

protocol DescriptableProtocol {
    var uuid: UUID { get }
    var id: Int { get }
    var title: String { get }
    var description: String { get }
    var thumbnailURL: String { get }
    var image: UIImage? { get set }
    var isFavorite: Bool { get }
    
    var firstAdditionalContent: [AdditionalContent]? { get set }
    var secondAdditionalContent: [AdditionalContent]? { get set }
    
    init(with cdo: DescriptableProtocolCDO)
}
