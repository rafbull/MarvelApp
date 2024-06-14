//
//  SearchResultTableViewController.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class SearchResultTableViewController: UITableViewController {
    // MARK: - Private Properties
    private let presenter: SearchPresenter
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        regiserCell()
        presenter.didLoad(searchResultUI: self)
    }
}

// MARK: - Extension
extension SearchResultTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getSearchResultTableViewRowsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell
        else { return UITableViewCell() }
        
        let searchResultContent = presenter.getSearchResultContent(at: indexPath.row)

        var configuration = cell.defaultContentConfiguration()
        configuration.text = searchResultContent?.title
        configuration.image = searchResultContent?.image
        cell.contentConfiguration = configuration

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapSearchResultContent(at: indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true)
    }
}

extension SearchResultTableViewController: SearchResultViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - Private Extension
private extension SearchResultTableViewController {
    func regiserCell() {
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
    }
}
