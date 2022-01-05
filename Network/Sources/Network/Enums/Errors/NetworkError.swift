//
//  File.swift
//  
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation

enum NetworkError: Swift.Error {

    enum Data: Swift.Error {
        case missing
        case read(underlying: DecodingError)
    }
    case corruptedURL
    case connection(reason: Swift.Error)
    case http(code: Int)
    case data(reason: Data)
    case other
}
