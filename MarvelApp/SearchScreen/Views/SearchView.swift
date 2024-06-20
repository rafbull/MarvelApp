//
//  SearchView.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class SearchView: UIView {
    // MARK: - Internal Properties
    private(set) lazy var searchController: UISearchController = {
        let searchController = UISearchController(
            searchResultsController: SearchResultTableViewController(presenter: presenter)
        )
        searchController.searchBar.placeholder = "Search"
        return searchController
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Private Properties
    private let presenter: SearchPresenter
    
    // MARK: - Initialization
    init(presenter: SearchPresenter) {
        self.presenter = presenter
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Extension
private extension SearchView {
    func setupUI() {
        backgroundColor = AppColor.background
        addSubview(tableView)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
