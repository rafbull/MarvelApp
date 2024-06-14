//
//  ContentListView.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class ContentListView: UIView {
    // MARK: - Internal Properties
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(
            ContentListCollectionViewCell.self,
            forCellWithReuseIdentifier: ContentListCollectionViewCell.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Private Constants
    private enum UIConstant {
        static let collectionViewItemSpacing: CGFloat = 8
        static let collectionViewGroupSpacing: CGFloat = 8
        static let collectionViewSectionContentInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        static let itemsInGroupCount: Int = 2
        static let groupHeight: CGFloat = 0.35
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Extension
private extension ContentListView {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(UIConstant.groupHeight)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: UIConstant.itemsInGroupCount
            )
            group.interItemSpacing = .fixed(UIConstant.collectionViewItemSpacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = UIConstant.collectionViewGroupSpacing
            section.contentInsets = UIConstant.collectionViewSectionContentInsets
            
            return section
        }
        
        return layout
    }
    
    func setupUI() {
        backgroundColor = AppColor.background
        addSubview(collectionView)
        addSubview(activityIndicatorView)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
