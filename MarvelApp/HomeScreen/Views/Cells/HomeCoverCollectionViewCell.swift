//
//  HomeCoverCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

final class HomeCoverCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: HomeCoverCollectionViewCell.self)
    
    // MARK: - Private Constants
    private enum UIConstant {
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: - Private Properties
    private let comicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let comicTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.title
        label.textColor = AppColor.fontColor
        label.backgroundColor = AppColor.cellBackground
        label.textAlignment = .center
        label.numberOfLines = 2
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
        comicTitleLabel.text = title.capitalized
    }
}

// MARK: - Private Extension
private extension HomeCoverCollectionViewCell {
    func setupUI() {
        setupCellLayer()
        contentView.addSubview(comicImageView)
        comicImageView.addSubview(comicTitleLabel)
        setConstraints()
    }
    
    func setupCellLayer() {
        backgroundColor = AppColor.cellBackground
        layer.cornerRadius = UIConstant.cornerRadius
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func setConstraints() {
        let contentViewMarginsGuide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            comicImageView.topAnchor.constraint(equalTo: contentViewMarginsGuide.topAnchor),
            comicImageView.leadingAnchor.constraint(equalTo: contentViewMarginsGuide.leadingAnchor),
            comicImageView.trailingAnchor.constraint(equalTo: contentViewMarginsGuide.trailingAnchor),
            comicImageView.bottomAnchor.constraint(equalTo: contentViewMarginsGuide.bottomAnchor),
            
            comicTitleLabel.bottomAnchor.constraint(equalTo: comicImageView.bottomAnchor),
            comicTitleLabel.centerXAnchor.constraint(equalTo: comicImageView.centerXAnchor),
            comicTitleLabel.widthAnchor.constraint(equalTo: comicImageView.widthAnchor),
        ])
    }
}
