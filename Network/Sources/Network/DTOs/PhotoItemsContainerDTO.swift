//
//  File.swift
//  
//
//  Created by Emrah Akgül on 9.01.2022.
//

import Foundation

public struct PhotoItemsContainerDTO: Decodable {

    public let page: Int?
    public let pages: Int?
    public let perpage: Int?
    public let total: Int?
    public let photos: Photos?

    public init(page: Int?, pages: Int?, perpage: Int?, total: Int?, photos: Photos?) {
        self.page = page
        self.pages = pages
        self.perpage = perpage
        self.total = total
        self.photos = photos
    }
}
