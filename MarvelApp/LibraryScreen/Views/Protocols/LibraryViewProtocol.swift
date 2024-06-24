//
//  LibraryViewProtocol.swift
//  MarvelApp
//
//  Created by Rafis on 09.06.2024.
//

import UIKit

protocol LibraryViewProtocol: AnyObject {
    func setNavigationBarHidden(_ hidden: Bool, animated: Bool)
    func setupDataSource(with: UICollectionViewDataSource?)
    
    func startLoadingAnimation()
    func stopLoadingAnimation()
    
    func scrollToCollectionViewSection(_ section: Int, animated: Bool)
    func selectSegmentedControlIndex(_ index: Int)
}
