//
//  UICollectionView+Reusable.swift
//  Flowers
//
//  Created by Ani Eduard on 11/02/2020.
//  Copyright © 2020 Ani Eduard. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    final func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func register<T: UICollectionViewCell>(cellType: T.Type) where T: NibRepresentable {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard and that you registered the cell beforehand."
            )
        }
        return cell
    }
    
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String) {
        register(supplementaryViewType.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: supplementaryViewType.reuseIdentifier)
    }
    
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String) where T: NibRepresentable {
        register(supplementaryViewType.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: supplementaryViewType.reuseIdentifier)
    }
    
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T {
        guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) matching type \(viewType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard and that you registered the supplementary view beforehand."
            )
        }
        return supplementaryView
    }
}

extension UICollectionReusableView: Reusable { }
