//
//  ContentDetailViewModel.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import Foundation

struct ContentDetailViewModel {
    var firstContentHeader: String
    var secondContentHeader: String
    
    var description: ContentDetailDescriptionViewModel?
    var firstContent: [ContentDetailOtherContentViewModel]
    var secondContent: [ContentDetailOtherContentViewModel]
}
