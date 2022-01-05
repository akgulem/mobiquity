//
//  File.swift
//  
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation

public enum HTTPMethod: String {

    case GET
    case POST
    case PUT
    case DELETE
}

public protocol Request {

    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
}
