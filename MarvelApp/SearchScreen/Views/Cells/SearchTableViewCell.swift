//
//  SearchTableViewCell.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    static let identifier = String(describing: SearchTableViewCell.self)
    
    // MARK: - Private Constants
    private enum UIConstant {
        static let contentImageViewHeightMultiplier: CGFloat = 0.4
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
        label.font = AppFont.title
        label.textColor = AppColor.coverComicFontColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
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
    }
    
    func setContentTitle(_ title: String) {
        contentTitleLabel.text = title
    }
}

// MARK: - Private Extension
private extension SearchTableViewCell {
    func setupUI() {
        contentView.addSubview(contentImageView)
        contentView.addSubview(contentTitleLabel)
        setConstraints()
    }
    
    func setConstraints() {
        let contentMargin = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            contentImageView.topAnchor.constraint(equalTo: contentMargin.topAnchor),
            contentImageView.leadingAnchor.constraint(equalTo: contentMargin.leadingAnchor),
            contentImageView.trailingAnchor.constraint(equalTo: contentMargin.trailingAnchor),
            contentImageView.bottomAnchor.constraint(equalTo: contentMargin.bottomAnchor),
            
            contentImageView.heightAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: UIConstant.contentImageViewHeightMultiplier
            ),
            
            contentTitleLabel.widthAnchor.constraint(equalTo: contentImageView.widthAnchor),
            contentTitleLabel.leadingAnchor.constraint(
                equalToSystemSpacingAfter: contentImageView.leadingAnchor,
                multiplier: 1.0
            ),
            contentTitleLabel.bottomAnchor.constraint(equalTo: contentImageView.bottomAnchor),
        ])
    }
}
