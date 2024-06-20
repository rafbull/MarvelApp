//
//  AdditionalContentCDO+CoreDataProperties.swift
//  MarvelApp
//
//  Created by Rafis on 15.06.2024.
//
//

import Foundation
import CoreData

extension AdditionalContentCDO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AdditionalContentCDO> {
        return NSFetchRequest<AdditionalContentCDO>(entityName: "AdditionalContentCDO")
    }

    @NSManaged public var contentID: Int64
    @NSManaged public var title: String
    @NSManaged public var imageData: Data?
    @NSManaged public var comicFirst: ComicCDO
    @NSManaged public var comicSecond: ComicCDO
    @NSManaged public var characterFirst: CharacterCDO
    @NSManaged public var characterSecond: CharacterCDO
    @NSManaged public var creatorFirst: CreatorCDO
    @NSManaged public var creatorSecond: CreatorCDO
    @NSManaged public var eventFirst: EventCDO
    @NSManaged public var eventSecond: EventCDO
    @NSManaged public var seriesFirst: SeriesCDO
    @NSManaged public var seriesSecond: SeriesCDO

}

// MARK: Generated accessors for comicFirst
extension AdditionalContentCDO {

    @objc(addComicFirstObject:)
    @NSManaged public func addToComicFirst(_ value: ComicCDO)

    @objc(removeComicFirstObject:)
    @NSManaged public func removeFromComicFirst(_ value: ComicCDO)

    @objc(addComicFirst:)
    @NSManaged public func addToComicFirst(_ values: NSSet)

    @objc(removeComicFirst:)
    @NSManaged public func removeFromComicFirst(_ values: NSSet)

}

// MARK: Generated accessors for comicSecond
extension AdditionalContentCDO {

    @objc(addComicSecondObject:)
    @NSManaged public func addToComicSecond(_ value: ComicCDO)

    @objc(removeComicSecondObject:)
    @NSManaged public func removeFromComicSecond(_ value: ComicCDO)

    @objc(addComicSecond:)
    @NSManaged public func addToComicSecond(_ values: NSSet)

    @objc(removeComicSecond:)
    @NSManaged public func removeFromComicSecond(_ values: NSSet)

}

// MARK: Generated accessors for characterFirst
extension AdditionalContentCDO {

    @objc(addCharacterFirstObject:)
    @NSManaged public func addToCharacterFirst(_ value: CharacterCDO)

    @objc(removeCharacterFirstObject:)
    @NSManaged public func removeFromCharacterFirst(_ value: CharacterCDO)

    @objc(addCharacterFirst:)
    @NSManaged public func addToCharacterFirst(_ values: NSSet)

    @objc(removeCharacterFirst:)
    @NSManaged public func removeFromCharacterFirst(_ values: NSSet)

}

// MARK: Generated accessors for characterSecond
extension AdditionalContentCDO {

    @objc(addCharacterSecondObject:)
    @NSManaged public func addToCharacterSecond(_ value: CharacterCDO)

    @objc(removeCharacterSecondObject:)
    @NSManaged public func removeFromCharacterSecond(_ value: CharacterCDO)

    @objc(addCharacterSecond:)
    @NSManaged public func addToCharacterSecond(_ values: NSSet)

    @objc(removeCharacterSecond:)
    @NSManaged public func removeFromCharacterSecond(_ values: NSSet)

}

// MARK: Generated accessors for creatorFirst
extension AdditionalContentCDO {

    @objc(addCreatorFirstObject:)
    @NSManaged public func addToCreatorFirst(_ value: CreatorCDO)

    @objc(removeCreatorFirstObject:)
    @NSManaged public func removeFromCreatorFirst(_ value: CreatorCDO)

    @objc(addCreatorFirst:)
    @NSManaged public func addToCreatorFirst(_ values: NSSet)

    @objc(removeCreatorFirst:)
    @NSManaged public func removeFromCreatorFirst(_ values: NSSet)

}

// MARK: Generated accessors for creatorSecond
extension AdditionalContentCDO {

    @objc(addCreatorSecondObject:)
    @NSManaged public func addToCreatorSecond(_ value: CreatorCDO)

    @objc(removeCreatorSecondObject:)
    @NSManaged public func removeFromCreatorSecond(_ value: CreatorCDO)

    @objc(addCreatorSecond:)
    @NSManaged public func addToCreatorSecond(_ values: NSSet)

    @objc(removeCreatorSecond:)
    @NSManaged public func removeFromCreatorSecond(_ values: NSSet)

}

// MARK: Generated accessors for eventFirst
extension AdditionalContentCDO {

    @objc(addEventFirstObject:)
    @NSManaged public func addToEventFirst(_ value: EventCDO)

    @objc(removeEventFirstObject:)
    @NSManaged public func removeFromEventFirst(_ value: EventCDO)

    @objc(addEventFirst:)
    @NSManaged public func addToEventFirst(_ values: NSSet)

    @objc(removeEventFirst:)
    @NSManaged public func removeFromEventFirst(_ values: NSSet)

}

// MARK: Generated accessors for eventSecond
extension AdditionalContentCDO {

    @objc(addEventSecondObject:)
    @NSManaged public func addToEventSecond(_ value: EventCDO)

    @objc(removeEventSecondObject:)
    @NSManaged public func removeFromEventSecond(_ value: EventCDO)

    @objc(addEventSecond:)
    @NSManaged public func addToEventSecond(_ values: NSSet)

    @objc(removeEventSecond:)
    @NSManaged public func removeFromEventSecond(_ values: NSSet)

}

// MARK: Generated accessors for seriesFirst
extension AdditionalContentCDO {

    @objc(addSeriesFirstObject:)
    @NSManaged public func addToSeriesFirst(_ value: SeriesCDO)

    @objc(removeSeriesFirstObject:)
    @NSManaged public func removeFromSeriesFirst(_ value: SeriesCDO)

    @objc(addSeriesFirst:)
    @NSManaged public func addToSeriesFirst(_ values: NSSet)

    @objc(removeSeriesFirst:)
    @NSManaged public func removeFromSeriesFirst(_ values: NSSet)

}

// MARK: Generated accessors for seriesSecond
extension AdditionalContentCDO {

    @objc(addSeriesSecondObject:)
    @NSManaged public func addToSeriesSecond(_ value: SeriesCDO)

    @objc(removeSeriesSecondObject:)
    @NSManaged public func removeFromSeriesSecond(_ value: SeriesCDO)

    @objc(addSeriesSecond:)
    @NSManaged public func addToSeriesSecond(_ values: NSSet)

    @objc(removeSeriesSecond:)
    @NSManaged public func removeFromSeriesSecond(_ values: NSSet)

}

extension AdditionalContentCDO : Identifiable {

}
