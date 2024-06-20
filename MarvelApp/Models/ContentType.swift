//
//  ContentType.swift
//  MarvelApp
//
//  Created by Rafis on 13.06.2024.
//

import Foundation

enum ContentType: String, CaseIterable {
    case comic = "Comics"
    case character = "Characters"
    case series = "Series"
    case event = "Events"
    case creator = "Creators"
    
    var firstAdditionalContent: ContentType {
        switch self {
        case .comic:
            return .character
        case .character:
            return .comic
        case .series:
            return .character
        case .event:
            return .comic
        case .creator:
            return .comic
        }
    }
    
    var secondAdditionalContent: ContentType {
        switch self {
        case .comic:
            return .creator
        case .character:
            return .series
        case .series:
            return .comic
        case .event:
            return .creator
        case .creator:
            return .event
        }
    }
}
