//
//  ContentDetailViewProtocol.swift
//  MarvelApp
//
//  Created by Rafis on 12.06.2024.
//

import UIKit

protocol ContentDetailViewProtocol: AnyObject {
    func setupDataSource(with: UICollectionViewDataSource?)
    
    func startLoadingAnimation()
    func stopLoadingAnimation()
}
