//
//  SearchViewPresenterTests.swift
//  AdyenTests
//
//  Created by Emrah Akgül on 4.01.2022.
//

import XCTest
@testable import Mobiquity
@testable import Network

enum CustomError: Error {

    case localizedTitle
    case localizedDescription
}

final class SearchViewPresenterTests: XCTestCase {

    private var view: MockSearchView!
    private var interactor: SearchViewInteractor!
    private var router: MockSearchViewRouter!
    private var sut: SearchViewPresenter!

    private var mockSearchImagesService = MockSearchImageService()
    private var mockSearchManager = MockSearchManager()

    override func setUp() {
        super.setUp()
        view = .init()
        router = .init()
        interactor = SearchViewInteractor(
            searchImagesService: mockSearchImagesService,
            searchManageable: mockSearchManager
        )
        sut = .init(view: view, router: router, interactor: interactor)
        interactor.output = sut
    }

    func test_whenViewDidLoad_ThenTableViewCollectionViewPageTitleAndNavigationBarAreInvoked() {
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertFalse(view.invokedPreparePageTitle)
        XCTAssertFalse(view.invokedPrepareCollectionView)
        XCTAssertFalse(view.invokedPrepareNavigationBar)
        XCTAssertEqual(view.invokedPrepareTableViewCount, 0)
        XCTAssertEqual(view.invokedPreparePageTitleCount, 0)
        XCTAssertEqual(view.invokedPrepareNavigationBarCount, 0)

        sut.viewDidLoad()
        XCTAssertTrue(view.invokedPrepareTableView)
        XCTAssertTrue(view.invokedPreparePageTitle)
        XCTAssertTrue(view.invokedPrepareCollectionView)
        XCTAssertTrue(view.invokedPrepareNavigationBar)
        XCTAssertEqual(view.invokedPrepareTableViewCount, 1)
        XCTAssertEqual(view.invokedPreparePageTitleCount, 1)
        XCTAssertEqual(view.invokedPrepareNavigationBarCount, 1)
    }

    func test_givenNotEmptySearchText_whenViewDidLoadAndSearched_ifThereAreResults_thenTableViewHiddenAndResultsAreShown() {
        XCTAssertFalse(mockSearchImagesService.invokedGetImages)

        // Given
        let searchText = "Dummy"
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

        mockSearchImagesService.stubbedGetImagesCompletionResult = Result<PhotosContainerDTO, Error>.success(result)

        // When
        sut.viewDidLoad()
        let prevCollectionViewCallCount = view.invokedPrepareCollectionViewCount
        sut.searchImages(with: searchText)
        let nextCollectionViewCallCount = view.invokedPrepareCollectionViewCount
        // Then
        XCTAssertTrue(mockSearchImagesService.invokedGetImages)
        XCTAssertEqual(prevCollectionViewCallCount + 1, nextCollectionViewCallCount)
    }
}
