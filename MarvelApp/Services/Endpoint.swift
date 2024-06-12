//
//  Endpoint.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

enum Endpoint {
    case comics
    case characters
    case creators
    case events
    case series
    case stories
    case comicID(_ id: String)
    case characterID(_ id: String)
    case creatorID(_ id: String)
    case eventID(_ id: String)
    case seriesID(_ id: String)
    case storyID(_ id: String)
    
    case weekNoveltiesComics
    case monthNoveltiesComics
    
    func absoluteURL() -> String {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.path = path
        components.queryItems = queryItems
        
        return components.url?.absoluteString ?? ""
    }
}

// MARK: - Private Extension
private extension Endpoint {
    var path: String {
        switch self {
        case .comics, .weekNoveltiesComics, .monthNoveltiesComics:
            return "/v1/public/comics"
        case .characters:
            return "/v1/public/characters"
        case .creators:
            return "/v1/public/creators"
        case .events:
            return "/v1/public/events"
        case .series:
            return "/v1/public/series"
        case .stories:
            return "/v1/public/stories"
        case .comicID(let id):
            return "/v1/public/comics/\(id)"
        case .characterID(let id):
            return "/v1/public/characters/\(id)"
        case .creatorID(let id):
            return "/v1/public/creators/\(id)"
        case .eventID(let id):
            return "/v1/public/events/\(id)"
        case .seriesID(let id):
            return "/v1/public/series/\(id)"
        case .storyID(let id):
            return "/v1/public/stories/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items = [
            URLQueryItem(name: "ts", value: APIConstant.ts),
            URLQueryItem(name: "apikey", value: APIConstant.apiKey),
            URLQueryItem(name: "hash", value: APIConstant.hash)
        ]
        
        switch self {
        case .weekNoveltiesComics:
            items.append(contentsOf: [
                URLQueryItem(name: "format", value: "comic"),
                URLQueryItem(name: "formatType", value: "comic"),
                URLQueryItem(name: "noVariants", value: "true"),
                URLQueryItem(name: "dateDescriptor", value: "thisWeek"),
                URLQueryItem(name: "hasDigitalIssue", value: "true"),
                URLQueryItem(name: "orderBy", value: "focDate"),
                URLQueryItem(name: "limit", value: "3")
            ])
        case .monthNoveltiesComics:
            items.append(contentsOf: [
                URLQueryItem(name: "format", value: "comic"),
                URLQueryItem(name: "formatType", value: "comic"),
                URLQueryItem(name: "noVariants", value: "true"),
                URLQueryItem(name: "dateDescriptor", value: "thisMonth"),
                URLQueryItem(name: "hasDigitalIssue", value: "true"),
                URLQueryItem(name: "orderBy", value: "focDate"),
                URLQueryItem(name: "limit", value: "10")
            ])
        case .comics:
            items.append(contentsOf: [
                URLQueryItem(name: "format", value: "comic"),
                URLQueryItem(name: "formatType", value: "comic"),
                URLQueryItem(name: "noVariants", value: "true"),
                URLQueryItem(name: "hasDigitalIssue", value: "true"),
                URLQueryItem(name: "orderBy", value: "focDate"),
                URLQueryItem(name: "limit", value: "20")
            ])
        case .characters:
            items.append(contentsOf: [
                URLQueryItem(name: "series", value: "24229"),
                URLQueryItem(name: "limit", value: "20")
            ])
        default:
            break
        }
        return items
    }
}
