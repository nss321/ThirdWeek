//
//  UIViewController+.swift
//  ThirdWeek
//
//  Created by BAE on 1/9/25.
//

import UIKit

extension UIViewController {
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        return layout
    }
}

class MyCollectionViewLayout: UICollectionViewLayout {
    
}

extension UICollectionViewDataSource {
    func configCollectionView() { }
    func configCollectionViewLayout() { }
    func registCell() { }
}
