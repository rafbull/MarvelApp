//
//  OnboardingView.swift
//  MarvelApp
//
//  Created by Rafis on 20.06.2024.
//

import UIKit

final class OnboardingView: UIView {
    // MARK: - Private Constants
    private enum UIConstant {
        static let onboardingTitleLabelBottomAnchorMultiplier: CGFloat = 20
    }
    
    // MARK: - Private Properties
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let onboardingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.title
        label.textColor = AppColor.onboardingTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
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
    func setBackgroundImage(_ named: String) {
        backgroundImageView.image = UIImage(named: named)
    }
    
    func setLabelText(_ text: String) {
        onboardingTitleLabel.text = text
    }

}

// MARK: - Private Extension
private extension OnboardingView {
    func setupUI() {
        backgroundColor = AppColor.background
        
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(onboardingTitleLabel)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            onboardingTitleLabel.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor),
            onboardingTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomAnchor.constraint(
                equalToSystemSpacingBelow: onboardingTitleLabel.bottomAnchor,
                multiplier: UIConstant.onboardingTitleLabelBottomAnchorMultiplier
            ),
        ])
    }
}
