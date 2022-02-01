//
//  UICollectionView + Cell.swift
//  Killiaro-Assignment
//
//  Created by Majid Khoshpour on 2/1/22.
//

import UIKit

public extension UICollectionView {

    /**
     Register nibs faster by passing the type - if for some reason the `identifier` is different then it can be passed
     - Parameter type: UICollectionViewCell.Type
     - Parameter identifier: String?
     */
    func registerCell(type: UICollectionViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: identifier ?? cellId)
    }

    /**
     DequeueCell by passing the type of UICollectionViewCell and IndexPath
     - Parameter type: UICollectionViewCell.Type
     - Parameter indexPath: IndexPath
     */
    func dequeueCell<T: UICollectionViewCell>(withType type: UICollectionViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }

}

public extension UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }

}
