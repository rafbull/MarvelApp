//
//  CoreDataServiceProtocol.swift
//  MarvelApp
//
//  Created by Rafis on 14.06.2024.
//

import Foundation

protocol CoreDataServiceProtocol {
    var hasChanges: Bool { get }
    
    func fetchAllComics(completion: @escaping (Result<[Comic], Error>) -> Void)
    func fetchAllCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
    func fetchAllEvents(completion: @escaping (Result<[Event], Error>) -> Void)
    func fetchAllSeries(completion: @escaping (Result<[Series], Error>) -> Void)
    func fetchAllCreators(completion: @escaping (Result<[Creator], Error>) -> Void)
    
    func fetchComic(with id: Int, completion: (Result<Comic, Error>) -> Void)
    func fetchCharacter(with id: Int, completion: (Result<Character, Error>) -> Void)
    func fetchCreator(with id: Int, completion: (Result<Creator, Error>) -> Void)
    func fetchSeries(with id: Int, completion: (Result<Series, Error>) -> Void)
    func fetchEvent(with id: Int, completion: (Result<Event, Error>) -> Void)
   
    func add(comic: Comic, completion: @escaping () -> Void)
    func add(character: Character, completion: @escaping () -> Void)
    func add(creator: Creator, completion: @escaping () -> Void)
    func add(series: Series, completion: @escaping () -> Void)
    func add(event: Event, completion: @escaping () -> Void)
    
    func removeComic(by uuid: UUID)
    func removeCharacter(by uuid: UUID)
    func removeCreator(by uuid: UUID)
    func removeSeries(by uuid: UUID)
    func removeEvent(by uuid: UUID)
}
