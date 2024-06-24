//
//  LibraryCollectionViewDataSource.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

final class LibraryCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    // MARK: - Private Properties
    private let libraryViewModel: LibraryViewModel
    
    private enum Section: CaseIterable {
        case comic
        case character
        case series
        case event
        case creator
    }
    
    // MARK: - Initialization
    init(_ libraryViewModel: LibraryViewModel) {
        self.libraryViewModel = libraryViewModel
    }
    
    // MARK: - Internal Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = Section.allCases[section]
        
        switch section {
        case .comic:
            return libraryViewModel.comics.count
        case .character:
            return libraryViewModel.characters.count
        case .series:
            return libraryViewModel.series.count
        case .event:
            return libraryViewModel.events.count
        case .creator:
            return libraryViewModel.creators.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section.allCases[indexPath.section]
        let defaultCell = UICollectionViewCell()
        
        switch section {
        case .comic:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryContentCollectionViewCell.identifier, for: indexPath) as? LibraryContentCollectionViewCell
            else { return defaultCell }
            cell.setContentTitle(libraryViewModel.comics[indexPath.item].title)
            cell.setContentImage(libraryViewModel.comics[indexPath.item].image)
            return cell
        case .character:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCharacterCollectionViewCell.identifier, for: indexPath) as? LibraryCharacterCollectionViewCell
            else { return defaultCell }
            cell.setCharacterName(libraryViewModel.characters[indexPath.item].title)
            cell.setCharacterImage(libraryViewModel.characters[indexPath.item].image)
            return cell
        case .series:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryContentCollectionViewCell.identifier, for: indexPath) as? LibraryContentCollectionViewCell
            else { return defaultCell }
            cell.setContentTitle(libraryViewModel.series[indexPath.item].title)
            cell.setContentImage(libraryViewModel.series[indexPath.item].image)
            return cell
        case .event:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryContentCollectionViewCell.identifier, for: indexPath) as? LibraryContentCollectionViewCell
            else { return defaultCell }
            cell.setContentTitle(libraryViewModel.events[indexPath.item].title)
            cell.setContentImage(libraryViewModel.events[indexPath.item].image)
            return cell
        case .creator:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryContentCollectionViewCell.identifier, for: indexPath) as? LibraryContentCollectionViewCell
            else { return defaultCell }
            cell.setContentTitle(libraryViewModel.creators[indexPath.item].title)
            cell.setContentImage(libraryViewModel.creators[indexPath.item].image)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: LibraryCollectionViewSectionHeaderView.headerKind,
            withReuseIdentifier: LibraryCollectionViewSectionHeaderView.identifier,
            for: indexPath
        ) as? LibraryCollectionViewSectionHeaderView
        else { return UICollectionReusableView() }
        
        let section = Section.allCases[indexPath.section]
        
        switch section {
        case .comic:
            header.setHeaderLabelTitle(libraryViewModel.comicsHeader)
        case .character:
            header.setHeaderLabelTitle(libraryViewModel.charactersHeader)
        case .series:
            header.setHeaderLabelTitle(libraryViewModel.seriesHeader)
        case .event:
            header.setHeaderLabelTitle(libraryViewModel.eventsHeader)
        case .creator:
            header.setHeaderLabelTitle(libraryViewModel.creatorsHeader)
        }
        
        return header
    }
}
