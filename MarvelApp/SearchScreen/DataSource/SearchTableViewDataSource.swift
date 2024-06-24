//
//  SearchTableViewDataSource.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

final class SearchTableViewDataSource: NSObject, UITableViewDataSource {
    // MARK: - Private Properties
    private let serchViewModels: [SearchContentViewModel]

    // MARK: - Initialization
    init(_ serchViewModels: [SearchContentViewModel]) {
        self.serchViewModels = serchViewModels
    }
    
    // MARK: - Internal Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        serchViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell
        else { return UITableViewCell() }
        
        cell.setContentTitle(serchViewModels[indexPath.row].title)
        cell.setContentImage(serchViewModels[indexPath.row].image)
        
        return cell
    }
}
