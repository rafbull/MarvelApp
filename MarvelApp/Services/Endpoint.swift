//
//  Endpoint.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import Foundation

#warning("убрать неиспользуемые эндроинты")
enum Endpoint {
    case comics
    case characters
    case creators
    case events
    case series
    case comicID(_ id: String)
    case characterID(_ id: String)
    case creatorID(_ id: String)
    case eventID(_ id: String)
    case seriesID(_ id: String)
    
    case comicsWithCharacterID(_ id: String)
    case seriesWithCharacterID(_ id: String)
    case charactersFromComicID(_ id: String)
    case creatorsWithComicID(_ id: String)
    case comicsWithCreatorID(_ id: String)
    case eventsWithCreatorID(_ id: String)
    case charactersWithSeriesID(_ id: String)
    case comicsWithSeriesID(_ id: String)
    case comicsWithEventID(_ id: String)
    case creatorsWithEventID(_ id: String)
    
    case weekNoveltiesComics
    case monthNoveltiesComics
    
    case character(_ name: String)
    
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
        case .characters, .character:
            return "/v1/public/characters"
        case .creators:
            return "/v1/public/creators"
        case .events:
            return "/v1/public/events"
        case .series:
            return "/v1/public/series"
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
        case .comicsWithCharacterID(let id):
            return "/v1/public/characters/\(id)/comics"
        case .seriesWithCharacterID(let id):
            return "/v1/public/characters/\(id)/series"
        case .charactersFromComicID(let id):
            return "/v1/public/comics/\(id)/characters"
        case .creatorsWithComicID(let id):
            return "/v1/public/comics/\(id)/creators"
        case .comicsWithCreatorID(let id):
            return "/v1/public/creators/\(id)/comics"
        case .eventsWithCreatorID(let id):
            return "/v1/public/creators/\(id)/events"
        case .charactersWithSeriesID(let id):
            return "/v1/public/series/\(id)/characters"
        case .comicsWithSeriesID(let id):
            return "/v1/public/series/\(id)/comics"
        case .comicsWithEventID(let id):
            return "/v1/public/events/\(id)/comics"
        case .creatorsWithEventID(let id):
            return "/v1/public/events/\(id)/creators"
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
        case .comics, .comicsWithCharacterID, .comicsWithCreatorID, .comicsWithSeriesID, .comicsWithEventID:
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
        case .character(let name):
            items.append(contentsOf: [
                URLQueryItem(name: "nameStartsWith", value: name),
                URLQueryItem(name: "orderBy", value: "name"),
                URLQueryItem(name: "limit", value: "10")
            ])
        case .creators, .creatorsWithComicID, .creatorsWithEventID:
            items.append(contentsOf: [
                URLQueryItem(name: "orderBy", value: "suffix"),
                URLQueryItem(name: "limit", value: "20")
            ])
        case .series, .seriesWithCharacterID:
            items.append(contentsOf: [
                URLQueryItem(name: "startYear", value: "2000"),
                URLQueryItem(name: "contains", value: "comic"),
                URLQueryItem(name: "orderBy", value: "-startYear"),
                URLQueryItem(name: "limit", value: "20")
            ])
        default:
            break
        }
        return items
    }
}
