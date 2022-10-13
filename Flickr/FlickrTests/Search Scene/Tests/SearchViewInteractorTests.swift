//
//  SearchViewInteractorTests.swift
//  FlickrTests
//
//  Created by Emrah Akgül on 8.01.2022.
//

import XCTest
@testable import Flickr
@testable import Network

final class SearchViewInteractorTests: XCTestCase {

    private var view: MockSearchView!
    private var sut: SearchViewInteractor!
    private var router: MockSearchViewRouter!
    private var presenter: MockSearchViewPresenter!

    private var searchImagesService: MockSearchImageService!
    private var searchManager: MockSearchManager!

    override func setUp() {
        super.setUp()

        searchImagesService = MockSearchImageService()
        searchManager = MockSearchManager()

        view = .init()
        router = .init()
        sut = SearchViewInteractor(searchImagesService: searchImagesService, searchManageable: searchManager)
        presenter = .init(view: view, router: router, interactor: sut)
        sut.output = presenter
    }

    func test_numberOfHistoryItems_InvokesSearchManagerNumberOfSearchHistories() {
        _ = sut.numberOfHistoryItems()
        XCTAssertTrue(searchManager.invokedNumberOfSearchHistoriesGetter)
    }

    func test_getSearchHistoryItem_InvokesSearchManagerGetSearchHistoryItem() {
        _ = sut.getSearchHistoryItem(at: .zero)
        XCTAssertTrue(searchManager.invokedGetSearchHistoryItem)
    }

    func test_saveSearchHistoryItem_InvokesSearchManagerSaveSearchHistoryItem() {
        sut.saveSearchHistoryItem(item: "")
        XCTAssertTrue(searchManager.invokedSaveSearchHistoryItem)
    }

    func test_reset_SetPagesToOneAndEmptiesDTOs() {
        sut.reset()
        XCTAssertEqual(sut.page, 1)
        XCTAssertEqual(sut.photoDTOs.count, .zero)
    }

    // swiftlint:disable line_length
    func test_search_IfImageRetrievalIsSuccessfulButNumberOfPageIsNotReturned_InvokePresenterHandleDTOTransformationMethod() {
        let photosContainerDTO = PhotosContainerDTO(
            photos: Photos(
                page: 2,
                pages: nil,
                perpage: 10,
                total: 100,
                photo: [
                    PhotoDTO(
                        id: "1",
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

        searchImagesService.stubbedGetImagesCompletionResult = .success(photosContainerDTO)
        sut.search(with: "")
        XCTAssertTrue(presenter.invokedHandleDtoTransformation)
        guard let result = presenter.invokedHandleDtoTransformationParameters?.0 else {
            XCTFail("Result can never be nil.")
            return
        }
        switch result {
        case .success(let successData):
            guard let photoDTOs = photosContainerDTO.photos?.photo else {
                XCTFail("Photo dtos can not be empty or nil.")
                return
            }
            XCTAssertEqual(successData.count, photoDTOs.count)
        case .failure(let error):
            XCTAssertEqual(error, ImageServiceError.photosCouldNotBeRetrieved)
        }
    }

    func test_search_IfImageRetrievalIsSuccessfulButNumberOfPageIsExceededCurrentPage_InvokePresenterHandleDTOTransformationMethod() {
        sut.page = 11
        let photosContainerDTO = PhotosContainerDTO(
            photos: Photos(
                page: 10,
                pages: 10,
                perpage: 10,
                total: 100,
                photo: [
                    PhotoDTO(
                        id: "1",
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
        searchImagesService.stubbedGetImagesCompletionResult = .success(photosContainerDTO)
        sut.search(with: "")
        XCTAssertTrue(presenter.invokedHandleDtoTransformation)
        guard let result = presenter.invokedHandleDtoTransformationParameters?.0 else {
            XCTFail("Result can never be nil.")
            return
        }
        switch result {
        case .success:
            XCTFail("Photo dtos can not come.")
        case .failure(let error):
            XCTAssertEqual(error, ImageServiceError.photosReachedEnd)
        }
    }

    func test_search_IfImageRetrievalIsSuccessful_InvokePresenterHandleDTOTransformationMethod() {
        let photosContainerDTO = PhotosContainerDTO(
            photos: Photos(
                page: 10,
                pages: 10,
                perpage: 10,
                total: 100,
                photo: [
                    PhotoDTO(
                        id: "1",
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
        searchImagesService.stubbedGetImagesCompletionResult = .success(photosContainerDTO)
        sut.search(with: "")
        XCTAssertTrue(presenter.invokedHandleDtoTransformation)
        guard let result = presenter.invokedHandleDtoTransformationParameters?.0 else {
            XCTFail("Result can never be nil.")
            return
        }
        switch result {
        case .success(let successData):
            guard let photoDTOs = photosContainerDTO.photos?.photo else {
                XCTFail("Photo dtos can not be empty or nil.")
                return
            }
            XCTAssertEqual(successData.count, photoDTOs.count)
        case .failure(let error):
            XCTAssertEqual(error, ImageServiceError.photosReachedEnd)
        }
    }

    func test_search_IfImageRetrievalIsUnsuccessful_InvokePresenterHandleDTOTransformation() {
        searchImagesService.stubbedGetImagesCompletionResult = .failure(NSError())
        sut.search(with: "")
        XCTAssertTrue(presenter.invokedHandleDtoTransformation)
        guard let result = presenter.invokedHandleDtoTransformationParameters?.0 else {
            XCTFail("Result can never be nil.")
            return
        }
        switch result {
        case .success:
            XCTFail("Result can not be photo dto")
        case .failure(let error):
            XCTAssertEqual(error, ImageServiceError.photosCouldNotBeRetrieved)
        }
    }
}
