//
//  CollectionViewPresenterInterface.swift
//  Flickr
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation

protocol CollectionViewPresenterInterface {

    var numberOfSections: Int { get }
    func numberOfItems(for section: Int) -> Int
}

extension CollectionViewPresenterInterface {

    var numberOfSections: Int {
        return 1
    }
}
