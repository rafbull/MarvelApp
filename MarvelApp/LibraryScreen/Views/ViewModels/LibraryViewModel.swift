//
//  LibraryViewModel.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import Foundation

struct LibraryViewModel {
    let comicsHeader = "Comics"
    let charactersHeader = "Characters"
    let seriesHeader = "Series"
    let eventsHeader = "Events"
    let creatorsHeader = "Creators"
    
    var comics: [DescriptableProtocol]
    var characters: [DescriptableProtocol]
    var series: [DescriptableProtocol]
    var events: [DescriptableProtocol]
    var creators: [DescriptableProtocol]
}
