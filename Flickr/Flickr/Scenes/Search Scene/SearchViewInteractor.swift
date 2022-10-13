//
//  SearchViewInteractor.swift
//  Flickr
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

    var output: SearchViewInteractorOutput? { get }
    func numberOfHistoryItems() -> Int
    func getSearchHistoryItem(at index: Int) -> String
    func saveSearchHistoryItem(item: String)

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
    private var searchManageable: SearchManageable
    var page: Int = 1
    var photoDTOs = [PhotoDTO]()

    init(searchImagesService: SearchImagesServiceProtocol, searchManageable: SearchManageable) {
        self.searchImagesService = searchImagesService
        self.searchManageable = searchManageable
    }
}

extension SearchViewInteractor: SearchViewInteractorInterface {

    func numberOfHistoryItems() -> Int {
        return searchManageable.numberOfSearchHistories
    }

    func getSearchHistoryItem(at index: Int) -> String {
        return searchManageable.getSearchHistoryItem(at: index)
    }

    func saveSearchHistoryItem(item: String) {
        searchManageable.saveSearchHistoryItem(item: item)
    }

    func search(with text: String) {
        searchImagesService.getImages(
            text: text,
            page: page,
            perPage: Constants.perPage
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dto):
                guard let photoDTOs = dto.photos?.photo, let pageCount = dto.photos?.pages else {
                    self.output?.handleDtoTransformation(result: .failure(.photosCouldNotBeRetrieved))
                    return
                }

                guard self.page <= pageCount else {
                    self.output?.handleDtoTransformation(result: .failure(.photosReachedEnd))
                    return
                }

                self.photoDTOs.append(contentsOf: photoDTOs)
                self.output?.handleDtoTransformation(result: .success(photoDTOs))
                self.page += 1
            case .failure:
                self.output?.handleDtoTransformation(result: .failure(ImageServiceError.photosCouldNotBeRetrieved))
            }
        }
    }

    func reset() {
        page = 1
        photoDTOs.removeAll()
    }
}
