//
//  HomeCoverCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

final class HomeCoverCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: HomeCoverCollectionViewCell.self)
    
    // MARK: - Private Properties
    private let comicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let comicTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.title
        label.textColor = AppColor.coverComicFontColor
        label.backgroundColor = AppColor.accentColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    func setComicImage(_ image: UIImage?) {
        comicImageView.image = image
    }
    
    func setComicTitle(_ title: String) {
        comicTitleLabel.text = title
    }
}

// MARK: - Private Extension
private extension HomeCoverCollectionViewCell {
    func setupUI() {
        contentView.addSubview(comicImageView)
        comicImageView.addSubview(comicTitleLabel)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            comicImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            comicImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            comicImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            comicImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            comicTitleLabel.bottomAnchor.constraint(equalTo: comicImageView.bottomAnchor),
            comicTitleLabel.centerXAnchor.constraint(equalTo: comicImageView.centerXAnchor),
            comicTitleLabel.widthAnchor.constraint(equalTo: comicImageView.widthAnchor),
        ])
    }
}
