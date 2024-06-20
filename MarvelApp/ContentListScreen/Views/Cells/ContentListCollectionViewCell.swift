//
//  ContentListCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class ContentListCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: ContentListCollectionViewCell.self)
    
    // MARK: - Private Constants
    private enum UIConstant {
        static let contentImageViewHeightMultiplier: CGFloat = 0.75
        static let cornerRadius: CGFloat = 10
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
    }
    
    func setContentTitle(_ title: String) {
        contentTitleLabel.text = title
    }
}

// MARK: - Private Extension
private extension ContentListCollectionViewCell {
    func setupUI() {
        backgroundColor = AppColor.cellBackground
        layer.cornerRadius = UIConstant.cornerRadius
        contentView.addSubview(contentVStackView)
        setConstraints()
    }
    
    func setConstraints() {
        let contentViewMarginsGuide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            contentVStackView.topAnchor.constraint(equalTo: contentViewMarginsGuide.topAnchor),
            contentVStackView.leadingAnchor.constraint(equalTo: contentViewMarginsGuide.leadingAnchor),
            contentVStackView.trailingAnchor.constraint(equalTo: contentViewMarginsGuide.trailingAnchor),
            contentVStackView.bottomAnchor.constraint(equalTo: contentViewMarginsGuide.bottomAnchor),
            
            contentImageView.heightAnchor.constraint(
                equalTo: contentVStackView.heightAnchor,
                multiplier: UIConstant.contentImageViewHeightMultiplier
            ),
        ])
    }
}
