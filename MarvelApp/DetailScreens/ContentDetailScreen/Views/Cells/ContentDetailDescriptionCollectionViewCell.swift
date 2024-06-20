//
//  ContentDetailDescriptionCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class ContentDetailDescriptionCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: ContentDetailDescriptionCollectionViewCell.self)
    
    // MARK: - Private Constants
    private enum UIConstant {
        static let contentImageViewHeightMultiplier: CGFloat = 1.3
        static let contentVStackViewSpacing: CGFloat = 8
    }
    
    // MARK: - Private Properties
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let contentTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.title
        label.textColor = AppColor.fontColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.body
        label.textColor = AppColor.fontColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentVStackView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [contentImageView, contentTitleLabel, contentDescriptionLabel])
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.distribution = .fill
        vStack.spacing = UIConstant.contentVStackViewSpacing
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
    }
    
    func setContentTitle(_ title: String?) {
        contentTitleLabel.text = title
    }
    
    func setContentDescription(_ description: String?) {
        contentDescriptionLabel.text = description?.htmlToString
    }
}

// MARK: - Private Extension
private extension ContentDetailDescriptionCollectionViewCell {
    func setupUI() {
        contentView.addSubview(contentVStackView)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            contentVStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentVStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentVStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentVStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentDescriptionLabel.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor),
            
            contentImageView.heightAnchor.constraint(
                equalTo: contentVStackView.widthAnchor,
                multiplier: UIConstant.contentImageViewHeightMultiplier
            ),
        ])
    }
}
