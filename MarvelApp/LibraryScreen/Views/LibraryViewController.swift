//
//  LibraryViewController.swift
//  MarvelApp
//
//  Created by Rafis on 08.06.2024.
//

import UIKit

final class LibraryViewController: UIViewController {
    // MARK: - Private Properties
    private let presenter: LibraryPresenter
    private lazy var contentView: LibraryView = {
        let contentView = LibraryView()
        contentView.segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        contentView.collectionView.delegate = self
        return contentView
    }()
    
    // MARK: - Initialization
    init(presenter: LibraryPresenter) {
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
extension LibraryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        presenter.didTapContent(at: indexPath)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollViewVisibleWidth = Int(scrollView.visibleSize.width)
        let contentOffsetX = Int(scrollView.contentOffset.x)
        
        guard scrollViewVisibleWidth != 0 else { return }
        let sectionIndex = contentOffsetX / scrollViewVisibleWidth

        presenter.scrollViewDidEndDecelerating(at: sectionIndex)
    }
}

// MARK: - Extension HomeViewProtocol
extension LibraryViewController: LibraryViewProtocol {
    
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
    
    func scrollToCollectionViewSection(_ section: Int, animated: Bool) {
        let xOffset = CGFloat(section) * contentView.collectionView.frame.width
        contentView.collectionView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: animated)
    }
    
    func selectSegmentedControlIndex(_ index: Int) {
        contentView.segmentedControl.selectedSegmentIndex = index
    }
}

// MARK: - Private Extension
private extension LibraryViewController {
    func setupUI() {
        navigationController?.navigationBar.tintColor = AppColor.accentColor
    }
    
    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        presenter.didSelectSegment(sender.selectedSegmentIndex)
    }
}
