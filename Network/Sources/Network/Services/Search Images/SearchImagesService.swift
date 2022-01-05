//
//  File.swift
//  
//
//  Created by Emrah Akgül on 6.01.2022.
//

import Foundation

public protocol SearchImagesServiceProtocol {

    func getImages(text: String, page: Int?, perPage: Int?, completion: @escaping (Result<[PhotosContainerDTO], Error>) -> Void)
}

public class SearchImagesAPIService: SearchImagesServiceProtocol {

    public let networkManageable: NetworkManageable

    public init(networkManageable: NetworkManageable = NetworkManager.default) {
        self.networkManageable = networkManageable
    }

    public func getImages(text: String, page: Int?, perPage: Int?, completion: @escaping (Result<[PhotosContainerDTO], Error>) -> Void) {

        let searchParameters = ImageSearchParameters(text: text, page: page, perPage: perPage)
        let searchImageServiceRequest = FlickrRequestCollection.getImages(parameters: searchParameters)
        networkManageable.execute(request: searchImageServiceRequest) { (result: Result<[PhotosContainerDTO], Error>) in
            completion(result)
        }
    }
}
