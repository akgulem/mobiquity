//
//  TableViewPresenterInterface.swift
//  Flickr
//
//  Created by Emrah Akgül on 7.01.2022.
//

import Foundation

protocol TableViewPresenterInterface {

    var numberOfSectionsForTableView: Int { get }
    func numberOfItemsForTableView(for section: Int) -> Int
}

extension TableViewPresenterInterface {

    var numberOfSectionsForTableView: Int {
        return 1
    }
}
