//
//  ContentDetailViewModel.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import Foundation

struct ContentDetailViewModel {
    var isFavorite: Bool
    let firstContentHeader: String
    let secondContentHeader: String
    
    var description: DescriptableProtocol?
    var firstContent: [AdditionalContent]
    var secondContent: [AdditionalContent]
}
