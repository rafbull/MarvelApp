//
//  ContentListViewProtocol.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

protocol ContentListViewProtocol: AnyObject {
    func setTitle(_ title: String)
    func setupDataSource(with: UICollectionViewDataSource?)
    
    func startLoadingAnimation()
    func stopLoadingAnimation()
}
