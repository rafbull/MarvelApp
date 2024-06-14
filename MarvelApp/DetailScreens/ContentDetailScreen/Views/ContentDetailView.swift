//
//  ContentDetailView.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class ContentDetailView: UIView {
    // MARK: - Internal Properties
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(
            ContentDetailDescriptionCollectionViewCell.self,
            forCellWithReuseIdentifier: ContentDetailDescriptionCollectionViewCell.identifier
        )
        collectionView.register(
            ContentDetailRoundCollectionViewCell.self,
            forCellWithReuseIdentifier: ContentDetailRoundCollectionViewCell.identifier
        )
        collectionView.register(
            ContentDetailOtherContentCollectionViewCell.self,
            forCellWithReuseIdentifier: ContentDetailOtherContentCollectionViewCell.identifier
        )
        
        collectionView.register(
            ContentDetailCollectionViewSectionHeaderView.self,
            forSupplementaryViewOfKind: ContentDetailCollectionViewSectionHeaderView.headerKind,
            withReuseIdentifier: ContentDetailCollectionViewSectionHeaderView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Private Constants
    private enum UIConstant {
        static let collectionViewItemSpacing: CGFloat = 8
        static let collectionViewGroupSpacing: CGFloat = 8
        static let collectionViewDescriptionGroupSpacing: CGFloat = 0
        static let collectionViewDescriptionSectionContentInsets: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        static let collectionViewSectionContentInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        static let itemsInDescriptionGroupCount: Int = 1
        static let itemsInGroupCount: Int = 2
        
        static let groupHeight: CGFloat = 0.35
        static let descriptionGroupHeight: CGFloat = 0.65
//        static let contentGroupHeight: CGFloat = 0.26
        
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
private extension ContentDetailView {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(UIConstant.sectionHeaderHeight)
            )
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: ContentDetailCollectionViewSectionHeaderView.headerKind,
                alignment: .top
            )
            
            let itemsInGroup = sectionIndex == 0 ?
            UIConstant.itemsInDescriptionGroupCount :
            UIConstant.itemsInGroupCount
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupHeight: CGFloat
            
            switch sectionIndex {
            case 0:
                groupHeight = UIConstant.descriptionGroupHeight
//            case 2:
//                groupHeight = UIConstant.contentGroupHeight
            default:
                groupHeight = UIConstant.groupHeight
            }
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(groupHeight)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: itemsInGroup)
            group.interItemSpacing = .fixed(UIConstant.collectionViewItemSpacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = sectionIndex == 0 ?
            UIConstant.collectionViewDescriptionGroupSpacing :
            UIConstant.collectionViewGroupSpacing
            
            section.contentInsets = sectionIndex == 0 ?
            UIConstant.collectionViewDescriptionSectionContentInsets :
            UIConstant.collectionViewSectionContentInsets
            
            section.orthogonalScrollingBehavior = sectionIndex == 0 ? .paging : .continuous
            section.boundarySupplementaryItems = sectionIndex == 0 ? [] : [sectionHeader]
            
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
