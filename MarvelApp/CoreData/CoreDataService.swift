//
//  CoreDataService.swift
//  MarvelApp
//
//  Created by Rafis on 14.06.2024.
//

import Foundation
import CoreData

final class CoreDataService: CoreDataServiceProtocol {
    // MARK: Internal Properties
    lazy var hasChanges: Bool = {
        persistentContainer.viewContext.hasChanges
    }()
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MarvelApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    private func saveContext () {
        let context = persistentContainer.viewContext
        hasChanges = context.hasChanges
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Fetching All Concrete Content
    func fetchAllComics(completion: @escaping (Result<[Comic], Error>) -> Void) {
        persistentContainer.performBackgroundTask { [weak self] _ in
            guard let context = self?.persistentContainer.viewContext else { return }
            self?.fetchAllContent(context: context, contentCDOType: ComicCDO.self, completion: completion)
        }
    }
    
    func fetchAllCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        persistentContainer.performBackgroundTask { [weak self] _ in
            guard let context = self?.persistentContainer.viewContext else { return }
            self?.fetchAllContent(context: context, contentCDOType: CharacterCDO.self, completion: completion)
        }
    }
    
    func fetchAllEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        persistentContainer.performBackgroundTask { [weak self] _ in
            guard let context = self?.persistentContainer.viewContext else { return }
            self?.fetchAllContent(context: context, contentCDOType: EventCDO.self, completion: completion)
        }
    }
    
    func fetchAllSeries(completion: @escaping (Result<[Series], Error>) -> Void) {
        persistentContainer.performBackgroundTask { [weak self] _ in
            guard let context = self?.persistentContainer.viewContext else { return }
            self?.fetchAllContent(context: context, contentCDOType: SeriesCDO.self, completion: completion)
        }
    }
    
    func fetchAllCreators(completion: @escaping (Result<[Creator], Error>) -> Void) {
        persistentContainer.performBackgroundTask { [weak self] _ in
            guard let context = self?.persistentContainer.viewContext else { return }
            self?.fetchAllContent(context: context, contentCDOType: CreatorCDO.self, completion: completion)
        }
    }
    
    // MARK: - Fetching Single Content
    func fetchComic(with id: Int, completion: (Result<Comic, Error>) -> Void) {
        let context = persistentContainer.viewContext
        fetchContent(with: id, context: context, contentCDOType: ComicCDO.self, completion: completion)
    }
    
    func fetchCharacter(with id: Int, completion: (Result<Character, Error>) -> Void) {
        let context = persistentContainer.viewContext
        fetchContent(with: id, context: context, contentCDOType: CharacterCDO.self, completion: completion)
    }
    
    func fetchCreator(with id: Int, completion: (Result<Creator, Error>) -> Void) {
        let context = persistentContainer.viewContext
        fetchContent(with: id, context: context, contentCDOType: CreatorCDO.self, completion: completion)
    }
    
    func fetchSeries(with id: Int, completion: (Result<Series, Error>) -> Void) {
        let context = persistentContainer.viewContext
        fetchContent(with: id, context: context, contentCDOType: SeriesCDO.self, completion: completion)
    }
    
    func fetchEvent(with id: Int, completion: (Result<Event, Error>) -> Void) {
        let context = persistentContainer.viewContext
        fetchContent(with: id, context: context, contentCDOType: EventCDO.self, completion: completion)
    }
    
    // MARK: - Adding Content
    func add(comic: Comic, completion: @escaping () -> Void) {
        persistentContainer.performBackgroundTask { [weak self] _ in
            guard let context = self?.persistentContainer.viewContext else { return }
            self?.add(content: comic, contentCDOType: ComicCDO.self, context: context, completion: completion)
        }
    }
    
    func add(character: Character, completion: @escaping () -> Void) {
        persistentContainer.performBackgroundTask { [weak self] _ in
            guard let context = self?.persistentContainer.viewContext else { return }
            self?.add(content: character, contentCDOType: CharacterCDO.self, context: context, completion: completion)
        }
    }
    
    func add(creator: Creator, completion: @escaping () -> Void) {
        persistentContainer.performBackgroundTask { [weak self] _ in
            guard let context = self?.persistentContainer.viewContext else { return }
            self?.add(content: creator, contentCDOType: CreatorCDO.self, context: context, completion: completion)
        }
    }
    
    func add(series: Series, completion: @escaping () -> Void) {
        persistentContainer.performBackgroundTask { [weak self] _ in
            guard let context = self?.persistentContainer.viewContext else { return }
            self?.add(content: series, contentCDOType: SeriesCDO.self, context: context, completion: completion)
        }
    }
    
    func add(event: Event, completion: @escaping () -> Void) {
        persistentContainer.performBackgroundTask { [weak self] _ in
            guard let context = self?.persistentContainer.viewContext else { return }
            self?.add(content: event, contentCDOType: EventCDO.self, context: context, completion: completion)
        }
    }
    
    // MARK: - Removing Content
    func removeComic(by uuid: UUID) {
        let context = persistentContainer.viewContext
        remove(by: uuid, contentCDOType: ComicCDO.self, context: context)
    }
    
    func removeCharacter(by uuid: UUID) {
        let context = persistentContainer.viewContext
        remove(by: uuid, contentCDOType: CharacterCDO.self, context: context)
    }
    
    func removeCreator(by uuid: UUID) {
        let context = persistentContainer.viewContext
        remove(by: uuid, contentCDOType: CreatorCDO.self, context: context)
    }
    
    func removeSeries(by uuid: UUID) {
        let context = persistentContainer.viewContext
        remove(by: uuid, contentCDOType: SeriesCDO.self, context: context)
    }
    
    func removeEvent(by uuid: UUID) {
        let context = persistentContainer.viewContext
        remove(by: uuid, contentCDOType: EventCDO.self, context: context)
    }
}

// MARK: - Private Extension
private extension CoreDataService {
    func fetchAllContent<T: DescriptableProtocol, U: NSManagedObject & DescriptableProtocolCDO>(
        context: NSManagedObjectContext,
        contentCDOType: U.Type,
        completion: (Result<[T], Error>) -> Void
    ) {
        let fetchRequest = contentCDOType.fetchRequest()
        do {
            guard let contents = try context.fetch(fetchRequest) as? [U] else {
                completion(.failure(FetchError.noData))
                return
            }
            completion(.success(contents.map { .init(with: $0) }))
        } catch {
            print("Error: ", error.localizedDescription)
            completion(.failure(FetchError.requestFailed(error)))
        }
    }
    
    func fetchContent<T: DescriptableProtocol, U: NSManagedObject & DescriptableProtocolCDO>(
        with contentID: Int,
        context: NSManagedObjectContext,
        contentCDOType: U.Type,
        completion: (Result<T, Error>) -> Void
    ) {
        let fetchRequest = contentCDOType.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "contentID == %@" , String(contentID))
        do {
            guard let content = try context.fetch(fetchRequest).first as? U else {
                completion(.failure(FetchError.noData))
                return
            }
            completion(.success(.init(with: content)))
        } catch {
            print("Error: ", error.localizedDescription)
            completion(.failure(FetchError.requestFailed(error)))
        }
    }
    
    func add<T: DescriptableProtocol, U: NSManagedObject & DescriptableProtocolCDO>(content: T, contentCDOType: U.Type, context: NSManagedObjectContext, completion: () -> Void) {
        defer {
            saveContext()
            completion()
        }
        
        var contentCDO = contentCDOType.init(context: context)
        
        contentCDO.uuid = content.uuid
        contentCDO.contentID = Int64(content.id)
        contentCDO.title = content.title
        contentCDO.isFavorite = content.isFavorite
        contentCDO.descriptionText = content.description
        contentCDO.thumbnailURL = content.thumbnailURL
        contentCDO.imageData = content.image?.pngData()
        
        let firstAdditionalContent = fetchAdditionalContentsCDO(with: content.firstAdditionalContent, context: context)
        let secondAdditionalContent = fetchAdditionalContentsCDO(with: content.secondAdditionalContent, context: context)
        
        contentCDO.firstAdditionalContent = Set(firstAdditionalContent)
        contentCDO.secondAdditionalContent = Set(secondAdditionalContent)
    }
    
    func remove<T: NSManagedObject & DescriptableProtocolCDO>(by uuid: UUID, contentCDOType: T.Type, context: NSManagedObjectContext) {
        defer {
            saveContext()
        }
        
        let fetchRequest = contentCDOType.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uuid == %@" , uuid.uuidString)
        do {
            guard let contents = try context.fetch(fetchRequest) as? [T] else { return }
            contents.forEach { context.delete($0) }
        } catch {
            fatalError("Could not delete item. \(error.localizedDescription)")
        }
    }
    
    func fetchAdditionalContentsCDO(with additionalContents: [AdditionalContent]?, context: NSManagedObjectContext) -> [AdditionalContentCDO] {
        guard let additionalContents = additionalContents else { return [] }
        
        return additionalContents.map { additionalContent in
            let additionalContentCDO = AdditionalContentCDO(context: context)
            additionalContentCDO.contentID = Int64(additionalContent.id)
            additionalContentCDO.title = additionalContent.title
            additionalContentCDO.imageData = additionalContent.image?.pngData()
            return additionalContentCDO
        }
    }
}
