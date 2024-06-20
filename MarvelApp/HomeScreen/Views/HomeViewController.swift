//
//  HomeViewController.swift
//  MarvelApp
//
//  Created by Rafis on 08.06.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Private Properties
    private let presenter: HomePresenter
    private lazy var contentView: HomeView = {
        let contentView = HomeView()
        contentView.collectionView.delegate = self
        return contentView
    }()
    
    // MARK: - Initialization
    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoad(ui: self)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.uiWillAppear(animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.uiWillDisappear(animated: animated)
    }
}

// MARK: - Extension UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didTapContent(at: indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - Extension HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        navigationController?.setNavigationBarHidden(hidden, animated: animated)
    }
    
    func setupDataSource(with dataSource: UICollectionViewDataSource?) {
        contentView.collectionView.dataSource = dataSource
    }
    
    func startLoadingAnimation() {
        contentView.collectionView.isHidden = true
        contentView.activityIndicatorView.startAnimating()
    }
    
    func stopLoadingAnimation() {
        contentView.collectionView.isHidden = false
        contentView.activityIndicatorView.stopAnimating()
    }
}

// MARK: - Private Extension
private extension HomeViewController {
    func setupUI() {
        navigationController?.navigationBar.tintColor = AppColor.accentColor
    }
}
