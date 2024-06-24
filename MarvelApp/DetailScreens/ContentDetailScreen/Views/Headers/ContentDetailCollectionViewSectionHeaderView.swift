//
//  ContentDetailCollectionViewSectionHeaderView.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class ContentDetailCollectionViewSectionHeaderView: UICollectionReusableView {
    static let identifier = String(describing: ContentDetailCollectionViewSectionHeaderView.self)
    static let headerKind = "SectionHeader"
    
    // MARK: - Private Properties
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = AppFont.header
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    func setHeaderLabelTitle(_ title: String) {
        headerLabel.text = title
    }
}

private extension ContentDetailCollectionViewSectionHeaderView {
    func setupUI() {
        addSubview(headerLabel)
        setConstraints()
    }
    
    func setConstraints() {
        let viewMargins = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: viewMargins.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: viewMargins.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: viewMargins.trailingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: viewMargins.bottomAnchor),
        ])
    }
}
