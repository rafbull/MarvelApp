//
//  ContentDetailRoundCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rafis on 14.06.2024.
//

import UIKit

final class ContentDetailRoundCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: ContentDetailRoundCollectionViewCell.self)
    
    // MARK: - Private Constants
    private enum UIConstant {
        static let contentImageViewWidthMultiplier: CGFloat = 0.8
    }
    
    // MARK: - Private Properties
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let contentTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.body
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentVStackView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [contentImageView, contentTitleLabel])
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.distribution = .fill
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    func setContentImage(_ image: UIImage?) {
        contentImageView.image = image
        layoutIfNeeded()
        contentImageView.layer.cornerRadius = contentImageView.bounds.width / 2
    }
    
    func setContentTitle(_ name: String) {
        contentTitleLabel.text = name
    }
}

// MARK: - Private Extension
private extension ContentDetailRoundCollectionViewCell {
    func setupUI() {
        contentView.addSubview(contentVStackView)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            contentVStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentVStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            contentVStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            contentVStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentImageView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: UIConstant.contentImageViewWidthMultiplier
            ),
            contentImageView.heightAnchor.constraint(equalTo: contentImageView.widthAnchor),
        ])
    }
}
