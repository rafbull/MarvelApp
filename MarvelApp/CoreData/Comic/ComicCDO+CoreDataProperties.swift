//
//  ComicCDO+CoreDataProperties.swift
//  MarvelApp
//
//  Created by Rafis on 15.06.2024.
//
//

import Foundation
import CoreData


extension ComicCDO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ComicCDO> {
        return NSFetchRequest<ComicCDO>(entityName: "ComicCDO")
    }

    @NSManaged public var descriptionText: String
    @NSManaged public var imageData: Data?
    @NSManaged public var title: String
    @NSManaged public var contentID: Int64
    @NSManaged public var isFavorite: Bool
    @NSManaged public var uuid: UUID
    @NSManaged public var thumbnailURL: String
    @NSManaged public var firstAdditionalContent: Set<AdditionalContentCDO>?
    @NSManaged public var secondAdditionalContent: Set<AdditionalContentCDO>?

}

// MARK: Generated accessors for firstAdditionalContent
extension ComicCDO {

    @objc(addFirstAdditionalContentObject:)
    @NSManaged public func addToFirstAdditionalContent(_ value: AdditionalContentCDO)

    @objc(removeFirstAdditionalContentObject:)
    @NSManaged public func removeFromFirstAdditionalContent(_ value: AdditionalContentCDO)

    @objc(addFirstAdditionalContent:)
    @NSManaged public func addToFirstAdditionalContent(_ values: NSSet)

    @objc(removeFirstAdditionalContent:)
    @NSManaged public func removeFromFirstAdditionalContent(_ values: NSSet)

}

// MARK: Generated accessors for secondAdditionalContent
extension ComicCDO {

    @objc(addSecondAdditionalContentObject:)
    @NSManaged public func addToSecondAdditionalContent(_ value: AdditionalContentCDO)

    @objc(removeSecondAdditionalContentObject:)
    @NSManaged public func removeFromSecondAdditionalContent(_ value: AdditionalContentCDO)

    @objc(addSecondAdditionalContent:)
    @NSManaged public func addToSecondAdditionalContent(_ values: NSSet)

    @objc(removeSecondAdditionalContent:)
    @NSManaged public func removeFromSecondAdditionalContent(_ values: NSSet)

}

extension ComicCDO : Identifiable {

}
