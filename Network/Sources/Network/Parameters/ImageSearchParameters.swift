//
//  File.swift
//  
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation

public struct ImageSearchParameters {

    var text: String
    var page: Int?
    var perPage: Int?

    public init(text: String, page: Int?, perPage: Int?) {
        self.text = text
        self.page = page
        self.perPage
    }
}
