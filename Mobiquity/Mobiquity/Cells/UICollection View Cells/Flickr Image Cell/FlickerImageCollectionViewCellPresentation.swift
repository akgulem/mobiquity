//
//  FlickerImageCollectionViewCellPresentation.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 6.01.2022.
//

import Foundation

struct FlickrImageCollectionViewCellPresentation: Hashable {

    let id: String
    let url: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
