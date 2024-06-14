//
//  ContentListCollectionViewDataSource.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class ContentListCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    // MARK: - Private Properties
    private let contentListViewModels: [ContentListViewModel]
    
    // MARK: - Initialization
    init(_ contentListViewModels: [ContentListViewModel]) {
        self.contentListViewModels = contentListViewModels
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contentListViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentListCollectionViewCell.identifier, for: indexPath) as? ContentListCollectionViewCell
        else { return UICollectionViewCell() }
            cell.setContentTitle(contentListViewModels[indexPath.item].title)
            cell.setContentImage(contentListViewModels[indexPath.item].image)
            return cell
    }
}
