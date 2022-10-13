//
//  File.swift
//  
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation

public struct PhotoDTO: Decodable {

    public let id: String?
    public let owner: String?
    public let secret: String?
    public let server: String?
    public let farm: Int?
    public let title: String?
    public let ispublic: Int?
    public let isfriend: Int?
    public let isfamily: Int?
    public var data: Data?

    public init(id: String?, owner: String?, secret: String?, server: String?, farm: Int?, title: String?, ispublic: Int?, isfriend: Int?, isfamily: Int?, data: Data? = nil) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily
        self.data = data
    }
}

public extension PhotoDTO {

    func getURL() -> String {
        guard let farm = farm, let server = server, let id = id, let secret = secret else {
            return ""
        }
        return "http://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
