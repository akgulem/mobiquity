//
//  MockSearchImageService.swift
//  MobiquityTests
//
//  Created by Emrah Akgül on 7.01.2022.
//

import Foundation
import Network

let result = PhotosContainerDTO(
    photos: Photos(
        page: 1,
        pages: 10,
        perpage: 10,
        total: 100,
        photo: [
            PhotoDTO(
                id: "",
                owner: "",
                secret: "",
                server: "",
                farm: nil,
                title: "",
                ispublic: nil,
                isfriend: nil,
                isfamily: nil
            )
        ]
    ), stat: ""
)

final class MockSearchImageService: SearchImagesServiceProtocol {

    var invokedGetImages = false
    var invokedGetImagesCount = 0
    // swiftlint:disable large_tuple
    var invokedGetImagesParameters: (text: String, page: Int?, perPage: Int?)?
    var invokedGetImagesParametersList = [(text: String, page: Int?, perPage: Int?)]()
    var stubbedGetImagesCompletionResult: Result<PhotosContainerDTO, Error>!

    func getImages(
        text: String,
        page: Int?,
        perPage: Int?,
        completion: @escaping (Result<PhotosContainerDTO, Error>
        ) -> Void) {
        invokedGetImages = true
        invokedGetImagesCount += 1
        invokedGetImagesParameters = (text, page, perPage)
        invokedGetImagesParametersList.append((text, page, perPage))
        guard let stubbedCompletionResult = stubbedGetImagesCompletionResult else {
            completion(.failure(NSError.init()))
            return
        }
        completion(stubbedCompletionResult)
    }
}
