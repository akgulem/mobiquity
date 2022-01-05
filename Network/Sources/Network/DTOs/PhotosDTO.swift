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
    public let total: String?
    public let photo: [PhotoDTO]?
}
