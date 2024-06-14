//
//  HomeCharacterCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

final class HomeCharacterCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: HomeCharacterCollectionViewCell.self)
    
    // MARK: - Private Constants
    private enum UIConstant {
        static let characterImageViewWidthMultiplier: CGFloat = 0.8
    }
    
    // MARK: - Private Properties
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.body
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentVStackView: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [characterImageView, characterNameLabel])
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
    func setCharacterImage(_ image: UIImage?) {
        characterImageView.image = image
        layoutIfNeeded()
        characterImageView.layer.cornerRadius = characterImageView.bounds.width / 2
    }
    
    func setCharacterName(_ name: String) {
        characterNameLabel.text = name
    }
}

// MARK: - Private Extension
private extension HomeCharacterCollectionViewCell {
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
            
            characterImageView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: UIConstant.characterImageViewWidthMultiplier
            ),
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor),
        ])
    }
}
