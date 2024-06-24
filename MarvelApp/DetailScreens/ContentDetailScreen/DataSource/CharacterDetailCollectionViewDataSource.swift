//
//  CharacterDetailCollectionViewDataSource.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class CharacterDetailCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    // MARK: - Private Properties
    private let characterDetailViewModel: CharacterDetailViewModel
    
    private enum Section: CaseIterable {
        case description
        case firstContent
        case secondContent
    }
    
    // MARK: - Initialization
    init(_ characterDetailViewModel: CharacterDetailViewModel) {
        self.characterDetailViewModel = characterDetailViewModel
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = Section.allCases[section]
        
        switch section {
        case .description:
            return 1
        case .firstContent:
            return characterDetailViewModel.comics.count
        case .secondContent:
            return characterDetailViewModel.series.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section.allCases[indexPath.section]
        let defaultCell = UICollectionViewCell()
        
        switch section {
        case .description:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterDetailDescriptionCollectionViewCell.identifier,
                for: indexPath
            ) as? CharacterDetailDescriptionCollectionViewCell
            else { return defaultCell }
            
            cell.setCharacterImage(characterDetailViewModel.description?.image)
            cell.setCharacterTitle(characterDetailViewModel.description?.name)
            cell.setCharacterDescription(characterDetailViewModel.description?.decription)
            return cell
        case .firstContent:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterDetailContentCollectionViewCell.identifier,
                for: indexPath
            ) as? CharacterDetailContentCollectionViewCell
            else { return defaultCell }
            cell.setContentImage(characterDetailViewModel.comics[indexPath.item].image)
            cell.setContentTitle(characterDetailViewModel.comics[indexPath.item].title)
            return cell
        case .secondContent:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterDetailContentCollectionViewCell.identifier,
                for: indexPath
            ) as? CharacterDetailContentCollectionViewCell
            else { return defaultCell }
            cell.setContentImage(characterDetailViewModel.series[indexPath.item].image)
            cell.setContentTitle(characterDetailViewModel.series[indexPath.item].title)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: CharacterDetailCollectionViewSectionHeaderView.headerKind,
            withReuseIdentifier: CharacterDetailCollectionViewSectionHeaderView.identifier,
            for: indexPath
        ) as? CharacterDetailCollectionViewSectionHeaderView
        else { return UICollectionReusableView() }
        
        let section = Section.allCases[indexPath.section]

        switch section {
        case .description:
            break
        case .firstContent:
            header.setHeaderLabelTitle(characterDetailViewModel.comicsHeader)
        case .secondContent:
            header.setHeaderLabelTitle(characterDetailViewModel.seriesHeader)
        }
        
        return header
    }
}
