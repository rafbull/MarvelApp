//
//  ContentDetailCollectionViewDataSource.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class ContentDetailCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    // MARK: - Private Properties
    private let contentDetailViewModel: ContentDetailViewModel
    
    private enum Section: CaseIterable {
        case description
        case firstContent
        case secondContent
    }
    
    // MARK: - Initialization
    init(_ contentDetailViewModel: ContentDetailViewModel) {
        self.contentDetailViewModel = contentDetailViewModel
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
            return contentDetailViewModel.firstContent.count
        case .secondContent:
            return contentDetailViewModel.secondContent.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section.allCases[indexPath.section]
        let defaultCell = UICollectionViewCell()
        defaultCell.backgroundColor = .red
        
        switch section {
        case .description:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContentDetailDescriptionCollectionViewCell.identifier,
                for: indexPath
            ) as? ContentDetailDescriptionCollectionViewCell
            else { return defaultCell }
            
            cell.setContentImage(contentDetailViewModel.description?.image)
            cell.setContentTitle(contentDetailViewModel.description?.title)
            cell.setContentDescription(contentDetailViewModel.description?.description)
            return cell
        case .firstContent:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContentDetailAdditionalContentCollectionViewCell.identifier,
                for: indexPath
            ) as? ContentDetailAdditionalContentCollectionViewCell
            else { return defaultCell }
            cell.setContentImage(contentDetailViewModel.firstContent[indexPath.item].image)
            cell.setContentTitle(contentDetailViewModel.firstContent[indexPath.item].title)
            return cell
        case .secondContent:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContentDetailAdditionalContentCollectionViewCell.identifier,
                for: indexPath
            ) as? ContentDetailAdditionalContentCollectionViewCell
            else { return defaultCell }
            cell.setContentImage(contentDetailViewModel.secondContent[indexPath.item].image)
            cell.setContentTitle(contentDetailViewModel.secondContent[indexPath.item].title)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: ContentDetailCollectionViewSectionHeaderView.headerKind,
            withReuseIdentifier: ContentDetailCollectionViewSectionHeaderView.identifier,
            for: indexPath
        ) as? ContentDetailCollectionViewSectionHeaderView
        else { return UICollectionReusableView() }
        
        let section = Section.allCases[indexPath.section]

        switch section {
        case .description:
            break
        case .firstContent:
            header.setHeaderLabelTitle(contentDetailViewModel.firstContentHeader)
        case .secondContent:
            header.setHeaderLabelTitle(contentDetailViewModel.secondContentHeader)
        }
        
        return header
    }
}
