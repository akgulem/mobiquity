//
//  File.swift
//  
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation

public struct Photos: Decodable {

    public let page: Int?
    public let pages: Int?
    public let perpage: Int?
    public let total: Int?
    public let photo: [PhotoDTO]?

    public init(page: Int?, pages: Int?, perpage: Int?, total: Int?, photo: [PhotoDTO]?) {
        self.page = page
        self.pages = pages
        self.perpage = perpage
        self.total = total
        self.photo = photo
    }
}
