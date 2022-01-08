//
//  File.swift
//  
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation

public enum FlickrRequestCollection {

    case getImages(parameters: ImageSearchParameters)
}

extension FlickrRequestCollection: Request {

    public var headers: [String : String] {
        return [:]
    }

    public var scheme: String {
        guard let scheme = Bundle.main.object(
            forInfoDictionaryKey: "FLICKR_URL_SCHEME"
        ) as? String, !scheme.isEmpty else {
            fatalError("Url scheme can't be nil or empty")
        }
        return scheme
    }

    public var baseURL: String {
        guard let baseURL = Bundle.main.object(
            forInfoDictionaryKey: "FLICKR_BASE_URL"
        ) as? String, !baseURL.isEmpty else {
            fatalError("Base URL can't be nil or empty")
        }
        return baseURL
    }

    public var apiKey: String {
        guard let apiKey = Bundle.main.object(
            forInfoDictionaryKey: "FLICKR_API_KEY"
        ) as? String, !apiKey.isEmpty else {
            fatalError("Api Key can't be nil")
        }
        return apiKey
    }

    public var responseFormat: String {
        guard let responseFormat = Bundle.main.object(
            forInfoDictionaryKey: "FLICKR_RESPONSE_FORMAT"
        ) as? String, !responseFormat.isEmpty else {
            fatalError("Response format can't be nil")
        }
        return responseFormat
    }

    public var path: String {
        switch self {
        case .getImages:
            return "/services/rest/"
        }
    }

    public var parameters: [URLQueryItem]? {
        var queryItems = [URLQueryItem]()
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        queryItems.append(apiKeyQueryItem)
        let responseFormatQueryItem = URLQueryItem(name: "format", value: responseFormat)
        queryItems.append(responseFormatQueryItem)
        let safeSearchQueryItem = URLQueryItem(name: "safe_search", value: "1")
        queryItems.append(safeSearchQueryItem)

        let jsonCallBackQueryItem = URLQueryItem(name: "nojsoncallback", value: "1")
        queryItems.append(jsonCallBackQueryItem)

        switch self {
        case .getImages(let parameters):
            let methodQueryItem = URLQueryItem(name: "method", value: "flickr.photos.search")
            let textQueryItem = URLQueryItem(name: "text", value: parameters.text)
            queryItems.append(contentsOf: [methodQueryItem, textQueryItem])

            if let page = parameters.page, let perPage = parameters.perPage {
                let pageQueryItem = URLQueryItem(name: "page", value: String(page))
                let perPageQueryItem = URLQueryItem(name: "per_page", value: String(perPage))
                queryItems.append(contentsOf: [pageQueryItem, perPageQueryItem])
            }

            return queryItems
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .getImages:
            return .GET
        }
    }

    public var body: Encodable? {
        switch self {
        case .getImages:
            return nil
        }
    }

}
