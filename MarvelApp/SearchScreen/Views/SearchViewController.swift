//
//  SearchViewController.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Private Properties
    private let presenter: SearchPresenter
    private lazy var contentView: SearchView = {
        let contentView = SearchView(presenter: presenter)
        contentView.searchController.searchResultsUpdater = self
        contentView.tableView.delegate = self
        return contentView
    }()
    
    // MARK: - Initialization
    init(presenter: SearchPresenter) {
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

// MARK: - Extension UITableViewDelegate
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter.didEnterSerchText(searchText)
    }
}

// MARK: - Extension UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapContent(at: indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Extension SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    func setupDataSource(with dataSource: UITableViewDataSource?) {
        contentView.tableView.dataSource = dataSource
    }
}

// MARK: - Private Extension
private extension SearchViewController {
    func setupUI() {
        navigationItem.searchController = contentView.searchController
        navigationController?.navigationBar.tintColor = AppColor.accentColor
    }
}
