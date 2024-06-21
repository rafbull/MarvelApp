//
//  HomeViewProtocol.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func setNavigationBarHidden(_ hidden: Bool, animated: Bool)
    func setupDataSource(with dataSource: UICollectionViewDataSource?)
    
    func startLoadingAnimation()
    func stopLoadingAnimation()
}
