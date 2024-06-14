//
//  SearchContentViewModel.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

struct SearchContentViewModel {
    let title: String
    var image: UIImage?
}

extension SearchContentViewModel {
    init(with dto: SearchContentDTO) {
        title = dto.title
        image = UIImage(named: dto.imageName)
    }
}
