//
//  LibraryView.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

final class LibraryView: UIView {
    // MARK: - Internal Properties
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()

    let segmentedControl: UISegmentedControl = {
        let items = ContentType.allCases.map { $0.rawValue }
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(
            LibraryContentCollectionViewCell.self,
            forCellWithReuseIdentifier: LibraryContentCollectionViewCell.identifier
        )
        collectionView.register(
            LibraryCharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: LibraryCharacterCollectionViewCell.identifier
        )
        collectionView.register(
            LibraryCollectionViewSectionHeaderView.self,
            forSupplementaryViewOfKind: LibraryCollectionViewSectionHeaderView.headerKind,
            withReuseIdentifier: LibraryCollectionViewSectionHeaderView.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Private Constants
    private enum UIConstant {
        static let segmentWidthMimimumScaleFactor: CGFloat = 0.5
        
        static let collectionViewItemSpacing: CGFloat = 8
        static let collectionViewGroupSpacing: CGFloat = 8
        static let collectionViewSectionContentInsets: NSDirectionalEdgeInsets = .init(top: 54, leading: 8, bottom: 8, trailing: 8)
        
        static let itemsInGroupCount: Int = 3
        
        static let groupHeight: CGFloat = 0.3
        static let characterGroupHeight: CGFloat = 0.25
        
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
private extension LibraryView {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in

            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(UIConstant.sectionHeaderHeight)
            )

            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: LibraryCollectionViewSectionHeaderView.headerKind,
                alignment: .top
            )
            
            let itemsInGroup = UIConstant.itemsInGroupCount
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupHeight: CGFloat

            switch sectionIndex {
            case 1:
                groupHeight = UIConstant.characterGroupHeight
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
            section.interGroupSpacing = UIConstant.collectionViewGroupSpacing
            section.contentInsets = UIConstant.collectionViewSectionContentInsets
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = [sectionHeader]
            section.supplementariesFollowContentInsets = false

            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        layout.configuration = config

        return layout
    }
    
    func setupUI() {
        backgroundColor = AppColor.background
        addSubview(collectionView)
        addSubview(activityIndicatorView)
        addSubview(segmentedControl)
        setSegmentWidths()
        setConstraints()
    }
    
    func setSegmentWidths() {
        segmentedControl.subviews.forEach {
            $0.subviews.forEach {
                ($0 as? UILabel)?.adjustsFontSizeToFitWidth = true
                ($0 as? UILabel)?.minimumScaleFactor = UIConstant.segmentWidthMimimumScaleFactor
            }
        }
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
