//
//  HomeCollectionViewDataSource.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

final class HomeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    // MARK: - Private Properties
    private let homeViewModel: HomeViewModel
    
    private enum Section: CaseIterable {
        case cover
        case actualComics
        case characters
        case monthNoveltiesComics
    }
    
    // MARK: - Initialization
    init(_ homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    // MARK: - Internal Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = Section.allCases[section]
        
        switch section {
        case .cover:
            return homeViewModel.coverComics.count
        case .actualComics:
            return homeViewModel.actualComics.count
        case .characters:
            return homeViewModel.characters.count
        case .monthNoveltiesComics:
            return homeViewModel.monthNoveltiesComics.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section.allCases[indexPath.section]
        let defaultCell = UICollectionViewCell()
        
        switch section {
        case .cover:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCoverCollectionViewCell.identifier, for: indexPath) as? HomeCoverCollectionViewCell
            else { return defaultCell }
            cell.setComicTitle(homeViewModel.coverComics[indexPath.item].title)
            cell.setComicImage(homeViewModel.coverComics[indexPath.item].image)
            return cell
        case .actualComics:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeComicCollectionViewCell.identifier, for: indexPath) as? HomeComicCollectionViewCell
            else { return defaultCell }
            cell.setComicTitle(homeViewModel.actualComics[indexPath.item].title)
            cell.setComicImage(homeViewModel.actualComics[indexPath.item].image)
            return cell
        case .characters:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCharacterCollectionViewCell.identifier, for: indexPath) as? HomeCharacterCollectionViewCell
            else { return defaultCell }
            cell.setCharacterName(homeViewModel.characters[indexPath.item].title)
            cell.setCharacterImage(homeViewModel.characters[indexPath.item].image)
            return cell
        case .monthNoveltiesComics:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeComicCollectionViewCell.identifier, for: indexPath) as? HomeComicCollectionViewCell
            else { return defaultCell }
            cell.setComicTitle(homeViewModel.monthNoveltiesComics[indexPath.item].title)
            cell.setComicImage(homeViewModel.monthNoveltiesComics[indexPath.item].image)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: HomeCollectionViewSectionHeaderView.headerKind,
            withReuseIdentifier: HomeCollectionViewSectionHeaderView.identifier,
            for: indexPath
        ) as? HomeCollectionViewSectionHeaderView
        else { return UICollectionReusableView() }
        
        let section = Section.allCases[indexPath.section]

        switch section {
        case .cover:
            break
        case .actualComics:
            header.setHeaderLabelTitle(homeViewModel.actualComicsHeader)
        case .characters:
            header.setHeaderLabelTitle(homeViewModel.charactersHeader)
        case .monthNoveltiesComics:
            header.setHeaderLabelTitle(homeViewModel.monthNoveltiesComicsHeader)
        }
        
        return header
    }
}
