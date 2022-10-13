//
//  FlickerImageCollectionViewCellPresentation.swift
//  Flickr
//
//  Created by Emrah Akgül on 6.01.2022.
//

import Foundation

// swiftlint:disable type_name
struct FlickrImageCollectionViewCellPresentation: Hashable {

    let id: String
    let url: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
