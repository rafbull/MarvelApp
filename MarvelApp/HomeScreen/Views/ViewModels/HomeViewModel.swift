//
//  HomeViewModel.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import Foundation

struct HomeViewModel {
    let actualComicsHeader = "Actual"
    let charactersHeader = "Characters"
    let monthNoveltiesComicsHeader = "Novelties"
    
    var coverComics: [DescriptableProtocol]
    var actualComics: [DescriptableProtocol]
    var characters: [DescriptableProtocol]
    var monthNoveltiesComics: [DescriptableProtocol]
}
