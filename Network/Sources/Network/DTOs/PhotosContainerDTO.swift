//
//  File.swift
//  
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation

public struct PhotosContainerDTO: Decodable {
    
    public let photos: Photos?
    public let stat: String?

    public init(photos: Photos?, stat: String?) {
        self.photos = photos
        self.stat = stat
    }
}
