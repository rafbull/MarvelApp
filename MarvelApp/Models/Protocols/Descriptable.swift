//
//  Descriptable.swift
//  MarvelApp
//
//  Created by Rafis on 14.06.2024.
//

import Foundation

protocol Descriptable {
    var id: Int { get }
    var title: String { get }
    var description: String { get }
    var thumbnailURL: String { get }
}
