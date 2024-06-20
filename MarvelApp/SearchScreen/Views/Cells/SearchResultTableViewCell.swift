//
//  SearchResultTableViewCell.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class SearchResultTableViewCell: UITableViewCell {
    static let identifier = String(describing: SearchResultTableViewCell.self)
    
    // MARK: - Private Constants
    private enum UIConstant {
        static let contentImageViewWidthMultiplier: CGFloat = 0.15
        static let contentHStackViewSpacing: CGFloat = 8
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
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentHStackView: UIStackView = {
        let hStack = UIStackView(arrangedSubviews: [contentImageView, contentTitleLabel])
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .fill
        hStack.spacing = UIConstant.contentHStackViewSpacing
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    func setContentTitle(_ title: String?) {
        contentTitleLabel.text = title
    }
}

// MARK: - Private Extension
private extension SearchResultTableViewCell {
    func setupUI() {
        contentView.addSubview(contentHStackView)
        setConstraints()
    }
    
    func setConstraints() {
        let contentMargin = contentView.layoutMarginsGuide

        let contentImageViewHeight =  contentImageView.heightAnchor.constraint(equalTo: contentImageView.widthAnchor)
        contentImageViewHeight.priority = .defaultHigh

        NSLayoutConstraint.activate([
            contentHStackView.topAnchor.constraint(equalTo: contentMargin.topAnchor),
            contentHStackView.leadingAnchor.constraint(equalTo: contentMargin.leadingAnchor),
            contentHStackView.trailingAnchor.constraint(equalTo: contentMargin.trailingAnchor),
            contentHStackView.bottomAnchor.constraint(equalTo: contentMargin.bottomAnchor),

            contentImageView.widthAnchor.constraint(
                equalTo: contentHStackView.widthAnchor,
                multiplier: UIConstant.contentImageViewWidthMultiplier
            ),
            contentImageViewHeight,
        ])
    }
}
