//
//  SearchViewInteractor.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation
import Network

enum ImageServiceError: Error {

    case photosCouldNotBeRetrieved
    case photosReachedEnd
}

protocol SearchViewInteractorInterface {

    func search(with text: String)
    func reset()
}

protocol SearchViewInteractorOutput: BaseInteractorOutput {

    func handleDtoTransformation(result: Result<[PhotoDTO], ImageServiceError>)
}

extension SearchViewInteractor {

    enum Constants {

        static let perPage = 10
    }
}

final class SearchViewInteractor {

    weak var output: SearchViewInteractorOutput?
    private var searchImagesService: SearchImagesServiceProtocol
    var page: Int = 1
    var photoDTOs = [PhotoDTO]()

    init(searchImagesService: SearchImagesServiceProtocol) {
        self.searchImagesService = searchImagesService
    }
}

extension SearchViewInteractor: SearchViewInteractorInterface {

    func search(with text: String) {
        searchImagesService.getImages(
            text: text,
            page: page,
            perPage: Constants.perPage
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dto):
                guard let photos = dto.photos, let photoDTOs = photos.photo, let pageCount = photos.pages else {
                    self.output?.handleDtoTransformation(result: .failure(ImageServiceError.photosCouldNotBeRetrieved))
                    return
                }

                guard self.page <= pageCount else {
                    self.output?.handleDtoTransformation(result: .failure(ImageServiceError.photosReachedEnd))
                    return
                }

                self.photoDTOs.append(contentsOf: photoDTOs)
                self.output?.handleDtoTransformation(result: .success(self.photoDTOs))
                self.page += 1
            case .failure:
                self.output?.handleDtoTransformation(result: .failure(ImageServiceError.photosCouldNotBeRetrieved))
            }
        }
    }

    func reset() {
        self.page = 1
        self.photoDTOs.removeAll()
    }
}
