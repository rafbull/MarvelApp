//
//  ContentListViewController.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class ContentListViewController: UIViewController {
    // MARK: - Private Properties
    private let presenter: ContentListPresenter
    private lazy var contentView: ContentListView = {
        let contentView = ContentListView()
        contentView.collectionView.delegate = self
        return contentView
    }()
    
    // MARK: - Initialization
    init(presenter: ContentListPresenter) {
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
}

// MARK: - Extension UICollectionViewDelegate
extension ContentListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didTapContent(at: indexPath.item)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - Extension HomeViewProtocol
extension ContentListViewController: ContentListViewProtocol {
    func setTitle(_ title: String) {
        self.title = title
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
private extension ContentListViewController {
    func setupUI() {
        navigationController?.navigationBar.tintColor = AppColor.accentColor
    }
}
