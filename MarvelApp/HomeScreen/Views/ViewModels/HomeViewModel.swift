//
//  HomeViewModel.swift
//  MarvelApp
//
//  Created by Rafis on 10.06.2024.
//

import UIKit

struct HomeViewModel {
    let actualComicsHeader = "Actual"
    let charactersHeader = "Characters"
    let monthNoveltiesComicsHeader = "Novelties"
    
    var coverComics: [HomeComicViewModel]
    var actualComics: [HomeComicViewModel]
    var characters: [HomeCharacterViewModel]
    var monthNoveltiesComics: [HomeComicViewModel]
}
