//
//  OnboardingViewController.swift
//  MarvelApp
//
//  Created by Rafis on 20.06.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    // MARK: - Private Properties
    private lazy var contentView = OnboardingView()
    
    // MARK: - Initialization
    init(with imageName: String, and labelText: String) {
        super.init(nibName: nil, bundle: nil)
        contentView.setBackgroundImage(imageName)
        contentView.setLabelText(labelText)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        view = contentView
    }
}
