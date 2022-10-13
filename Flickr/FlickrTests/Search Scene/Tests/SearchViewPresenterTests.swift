//
//  SearchViewPresenterTests.swift
//  AdyenTests
//
//  Created by Emrah Akgül on 4.01.2022.
//

import XCTest
@testable import Flickr
@testable import Network

enum CustomError: Error {

    case localizedTitle
    case localizedDescription
}

final class SearchViewPresenterTests: XCTestCase {

    private var view: MockSearchView!
    private var interactor: MockSearchViewInteractor!
    private var router: MockSearchViewRouter!
    private var sut: SearchViewPresenter!

    override func setUp() {
        super.setUp()
        view = .init()
        router = .init()
        interactor = .init()
        sut = .init(view: view, router: router, interactor: interactor)
        interactor.stubbedOutput = sut
    }

    func test_didLoad_InvokesTableViewCollectionViewPageTitleAndNavigationBar() {
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

    func test_saveHistoryItem_InvokesInteractorSaveSearchHistoryItem() {
        XCTAssertFalse(interactor.invokedSaveSearchHistoryItem)
        XCTAssertEqual(interactor.invokedSaveSearchHistoryItemCount, .zero)
        sut.saveHistoryItem(item: "")
        XCTAssertTrue(interactor.invokedSaveSearchHistoryItem)
        XCTAssertEqual(interactor.invokedSaveSearchHistoryItemCount, 1)
    }

    func test_historyItemPresentation_IfThereIsAGetSearchHistoryItem_InvokesInteractorGetSearchHistoryItem() {
        let prevCount = interactor.invokedGetSearchHistoryItemCount
        interactor.stubbedGetSearchHistoryItemResult = "dummy result"
        let result = sut.historyItemPresentation(for: .zero)
        let nextCount = interactor.invokedGetSearchHistoryItemCount
        XCTAssertEqual("dummy result", result)
        XCTAssertTrue(interactor.invokedGetSearchHistoryItem)
        XCTAssertEqual(prevCount + 1, nextCount)
    }

    func test_historyItemPresentation_IfInteractorIsNil_ResultIsEmptyString() {
        sut = .init(view: view, router: router, interactor: nil)
        let result = sut.historyItemPresentation(for: .zero)
        XCTAssertEqual("", result)
    }

    func test_numberOfItemsForTableView_IfSectionIsNotZero_ResultIsZero() {
        let notZeroNumber = Int.random(in: 1..<Int.max)
        let result = sut.numberOfItemsForTableView(for: notZeroNumber)
        XCTAssertEqual(result, .zero)
    }

    func test_numberOfItemsForTableView_IfSectionIsZero_InvokesInteractorNumberOfHistoryItems() {
        let randomNumberOfItems = Int.random(in: 0..<Int.max)
        interactor.stubbedNumberOfHistoryItemsResult = randomNumberOfItems
        let result = sut.numberOfItemsForTableView(for: .zero)
        XCTAssertTrue(interactor.invokedNumberOfHistoryItems)
        XCTAssertEqual(result, randomNumberOfItems)
    }

    func test_numberOfItemsForTableView_IfInteractorIsNil_ResultIsZero() {
        sut = .init(view: view, router: router, interactor: nil)
        let result = sut.numberOfItemsForTableView(for: .zero)
        XCTAssertEqual(result, .zero)
    }

    func test_cellPresentation_IfIndexPathSectionIsNotZero_ResultIsNil() {
        let randomNotZeroSection = Int.random(in: 1..<Int.max)
        let randomRow = Int.random(in: 0..<Int.max)
        let indexPath = IndexPath(row: randomRow, section: randomNotZeroSection)
        let cellPresentation = sut.cellPresentation(for: indexPath)
        XCTAssertNil(cellPresentation)
    }

    func test_cellPresentation_IfIndexPathSectionIsZeroAndThereAreCellPresentations_ResultIs() {
        let photoDTOs = [
            PhotoDTO(
                id: "1",
                owner: "",
                secret: "",
                server: "",
                farm: .zero,
                title: "",
                ispublic: .zero,
                isfriend: .zero,
                isfamily: .zero
            ),
            PhotoDTO(
                id: "2",
                owner: "",
                secret: "",
                server: "",
                farm: .zero,
                title: "",
                ispublic: .zero,
                isfriend: .zero,
                isfamily: .zero
            )
        ]

        let randomRow = Int.random(in: .zero..<photoDTOs.count)
        let indexPath = IndexPath(row: randomRow, section: .zero)
        sut.handleDtoTransformation(result: .success(photoDTOs))
        let cellPresentation = sut.cellPresentation(for: indexPath)
        let selectedCellPresentation = FlickrImageCollectionViewCellPresentation(
            id: photoDTOs[indexPath.row].id ?? "",
            url: photoDTOs[indexPath.row].getURL()
        )
        XCTAssertEqual(cellPresentation?.id ?? "", selectedCellPresentation.id)
    }

    func test_clearSearchResults_InvokesInteractorResetAndViewReloadCollectionMethods() {
        let photoDTOs = [
            PhotoDTO(
                id: "1",
                owner: "",
                secret: "",
                server: "",
                farm: .zero,
                title: "",
                ispublic: .zero,
                isfriend: .zero,
                isfamily: .zero
            ),
            PhotoDTO(
                id: "2",
                owner: "",
                secret: "",
                server: "",
                farm: .zero,
                title: "",
                ispublic: .zero,
                isfriend: .zero,
                isfamily: .zero
            )
        ]
        sut.handleDtoTransformation(result: .success(photoDTOs))
        let prevNumberOfRows = sut.numberOfItems(for: .zero)
        let prevResetCount = interactor.invokedResetCount
        sut.clearSearchResults()
        let nextResetCount = interactor.invokedResetCount
        let nextNumberOfRows = sut.numberOfItems(for: .zero)
        XCTAssertTrue(interactor.invokedReset)
        XCTAssertEqual(prevResetCount + 1, nextResetCount)
        XCTAssertTrue(view.invokedReloadCollectionView)
        XCTAssertNotEqual(prevNumberOfRows, nextNumberOfRows)
        XCTAssertEqual(nextNumberOfRows, .zero)
    }

    func test_searchImages_InvokesInteractorSearch() {
        let text = "Dummy Text"
        sut.searchImages(with: text)
        XCTAssertTrue(interactor.invokedSearch)
    }

    func test_numberOfItems_IfSectionIsNotZero_ReturnsZero() {
        let randomNotZeroSection = Int.random(in: 1..<Int.max)
        let result = sut.numberOfItems(for: randomNotZeroSection)
        XCTAssertEqual(result, .zero)
    }

    func test_handleDtoTransformation_IfPhotoDTOIdsAreNil_CellPresentationIdsAreEmptyString() {
        let photoDTOs = [
            PhotoDTO(
                id: nil,
                owner: "",
                secret: "",
                server: "",
                farm: .zero,
                title: "",
                ispublic: .zero,
                isfriend: .zero,
                isfamily: .zero
            ),
            PhotoDTO(
                id: nil,
                owner: "",
                secret: "",
                server: "",
                farm: .zero,
                title: "",
                ispublic: .zero,
                isfriend: .zero,
                isfamily: .zero
            )
        ]
        sut.handleDtoTransformation(result: .success(photoDTOs))
        guard let firstCellPresentation = sut.cellPresentation(for: IndexPath(row: .zero, section: .zero)),
              let secondCellPresentation = sut.cellPresentation(for: IndexPath(row: .zero, section: .zero)) else {
                  XCTFail("Cell presentations are nil. Can't be proceeded.")
            return
        }
        XCTAssertEqual(firstCellPresentation.id, "")
        XCTAssertEqual(secondCellPresentation.id, "")
    }

    func test_handleDtoTransformation_IfResultIsPhotoReachesEndError_InvokesViewShowError() {
        let result = Result<[PhotoDTO], ImageServiceError>.failure(ImageServiceError.photosReachedEnd)
        interactor.output?.handleDtoTransformation(result: result)
        XCTAssertTrue(view.invokedShowError)
        XCTAssertEqual(view.invokedShowErrorParameters?.0, "Error")
        XCTAssertEqual(view.invokedShowErrorParameters?.1, "There are no more photos")
        XCTAssertEqual(view.invokedShowErrorParameters?.2, .alert)
    }

    func test_handleDtoTransformation_IfResultIsPhotosCouldNotBeRetrievedError_InvokesViewShowError() {
        let result = Result<[PhotoDTO], ImageServiceError>.failure(ImageServiceError.photosCouldNotBeRetrieved)
        interactor.output?.handleDtoTransformation(result: result)
        XCTAssertTrue(view.invokedShowError)
        XCTAssertEqual(view.invokedShowErrorParameters?.0, "Error")
        XCTAssertEqual(view.invokedShowErrorParameters?.1, "Photos could not be retrieved. Try again later")
        XCTAssertEqual(view.invokedShowErrorParameters?.2, .alert)
    }
}
