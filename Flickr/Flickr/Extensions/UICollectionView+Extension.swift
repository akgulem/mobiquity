//
//  UICollectionView+Extension.swift
//  Flickr
//
//  Created by Emrah Akgül on 5.01.2022.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType.self)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(
        with type: T.Type,
        for indexPath: IndexPath
    ) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type.self), for: indexPath) as? T
    }
}
