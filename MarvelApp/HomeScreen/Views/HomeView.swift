//
//  HomeView.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

final class HomeView: UIView {
    // MARK: - Internal Properties
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.register(
            HomeCoverCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeCoverCollectionViewCell.identifier
        )
        collectionView.register(
            HomeComicCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeComicCollectionViewCell.identifier
        )
        collectionView.register(
            HomeCharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeCharacterCollectionViewCell.identifier
        )
        collectionView.register(
            HomeCollectionViewSectionHeaderView.self,
            forSupplementaryViewOfKind: HomeCollectionViewSectionHeaderView.headerKind,
            withReuseIdentifier: HomeCollectionViewSectionHeaderView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Private Constants
    private enum UIConstant {
        static let collectionViewItemSpacing: CGFloat = 8
        static let collectionViewGroupSpacing: CGFloat = 8
        static let collectionViewCoverGroupSpacing: CGFloat = 0
        static let collectionViewCoverSectionContentInsets: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        static let collectionViewSectionContentInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        static let ItemsInCoverGroupCount: Int = 1
        static let ItemsInGroupCount: Int = 2
        
        static let GroupHeight: CGFloat = 0.35
        static let CoverGroupHeight: CGFloat = 0.65
        static let CharacterGroupHeight: CGFloat = 0.26
        
        static let sectionHeaderHeight: CGFloat = 44
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
private extension HomeView {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(UIConstant.sectionHeaderHeight)
            )
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: HomeCollectionViewSectionHeaderView.headerKind,
                alignment: .top
            )
            
            let itemsInGroup = sectionIndex == 0 ?
            UIConstant.ItemsInCoverGroupCount :
            UIConstant.ItemsInGroupCount
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            
            let groupHeight: CGFloat
            
            switch sectionIndex {
            case 0:
                groupHeight = UIConstant.CoverGroupHeight
            case 2:
                groupHeight = UIConstant.CharacterGroupHeight
            default:
                groupHeight = UIConstant.GroupHeight
            }
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(groupHeight)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: itemsInGroup)
            group.interItemSpacing = .fixed(UIConstant.collectionViewItemSpacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = sectionIndex == 0 ?
            UIConstant.collectionViewCoverGroupSpacing :
            UIConstant.collectionViewGroupSpacing
            
            section.contentInsets = sectionIndex == 0 ?
            UIConstant.collectionViewCoverSectionContentInsets :
            UIConstant.collectionViewSectionContentInsets
            
            section.orthogonalScrollingBehavior = sectionIndex == 0 ? .paging : .continuous
            section.boundarySupplementaryItems = sectionIndex == 0 ? [] : [sectionHeader]
            
            return section
        }
        return layout
    }
    
    func setupUI() {
        backgroundColor = .systemBackground
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
