//
//  MockSearchViewPresenter.swift
//  FlickrTests
//
//  Created by Emrah Akgül on 8.01.2022.
//

import Foundation
@testable import Flickr
@testable import Network

final class MockSearchViewPresenter: SearchViewPresenterInterface, SearchViewInteractorOutput {

    var view: SearchViewInterface?
    var router: SearchViewRouterInterface?
    var interactor: SearchViewInteractorInterface?

    init(
        view: SearchViewInterface?,
        router: SearchViewRouterInterface?,
        interactor: SearchViewInteractorInterface?
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    var invokedNumberOfSectionsForTableViewGetter = false
    var invokedNumberOfSectionsForTableViewGetterCount = 0
    var stubbedNumberOfSectionsForTableView: Int! = 0

    var numberOfSectionsForTableView: Int {
        invokedNumberOfSectionsForTableViewGetter = true
        invokedNumberOfSectionsForTableViewGetterCount += 1
        return stubbedNumberOfSectionsForTableView
    }

    var invokedNumberOfSectionsGetter = false
    var invokedNumberOfSectionsGetterCount = 0
    var stubbedNumberOfSections: Int! = 0

    var numberOfSections: Int {
        invokedNumberOfSectionsGetter = true
        invokedNumberOfSectionsGetterCount += 1
        return stubbedNumberOfSections
    }

    var invokedHistoryItemPresentation = false
    var invokedHistoryItemPresentationCount = 0
    var invokedHistoryItemPresentationParameters: (index: Int, Void)?
    var invokedHistoryItemPresentationParametersList = [(index: Int, Void)]()
    var stubbedHistoryItemPresentationResult: String! = ""

    func historyItemPresentation(for index: Int) -> String {
        invokedHistoryItemPresentation = true
        invokedHistoryItemPresentationCount += 1
        invokedHistoryItemPresentationParameters = (index, ())
        invokedHistoryItemPresentationParametersList.append((index, ()))
        return stubbedHistoryItemPresentationResult
    }

    var invokedSaveHistoryItem = false
    var invokedSaveHistoryItemCount = 0
    var invokedSaveHistoryItemParameters: (item: String, Void)?
    var invokedSaveHistoryItemParametersList = [(item: String, Void)]()

    func saveHistoryItem(item: String) {
        invokedSaveHistoryItem = true
        invokedSaveHistoryItemCount += 1
        invokedSaveHistoryItemParameters = (item, ())
        invokedSaveHistoryItemParametersList.append((item, ()))
    }

    var invokedClearSearchResults = false
    var invokedClearSearchResultsCount = 0

    func clearSearchResults() {
        invokedClearSearchResults = true
        invokedClearSearchResultsCount += 1
    }

    var invokedSearchImages = false
    var invokedSearchImagesCount = 0
    var invokedSearchImagesParameters: (text: String, Void)?
    var invokedSearchImagesParametersList = [(text: String, Void)]()

    func searchImages(with text: String) {
        invokedSearchImages = true
        invokedSearchImagesCount += 1
        invokedSearchImagesParameters = (text, ())
        invokedSearchImagesParametersList.append((text, ()))
    }

    var invokedCellPresentation = false
    var invokedCellPresentationCount = 0
    var invokedCellPresentationParameters: (indexPath: IndexPath, Void)?
    var invokedCellPresentationParametersList = [(indexPath: IndexPath, Void)]()
    var stubbedCellPresentationResult: FlickrImageCollectionViewCellPresentation!

    func cellPresentation(for indexPath: IndexPath) -> FlickrImageCollectionViewCellPresentation? {
        invokedCellPresentation = true
        invokedCellPresentationCount += 1
        invokedCellPresentationParameters = (indexPath, ())
        invokedCellPresentationParametersList.append((indexPath, ()))
        return stubbedCellPresentationResult
    }

    var invokedHandleDtoTransformation = false
    var invokedHandleDtoTransformationCount = 0
    var invokedHandleDtoTransformationParameters: (result: Result<[PhotoDTO], ImageServiceError>, Void)?

    func handleDtoTransformation(result: Result<[PhotoDTO], ImageServiceError>) {
        invokedHandleDtoTransformation = true
        invokedHandleDtoTransformationCount += 1
        invokedHandleDtoTransformationParameters = (result, ())
    }

    var invokedViewDidLoad = false
    var invokedViewDidLoadCount = 0

    func viewDidLoad() {
        invokedViewDidLoad = true
        invokedViewDidLoadCount += 1
    }

    var invokedNumberOfItemsForTableView = false
    var invokedNumberOfItemsForTableViewCount = 0
    var invokedNumberOfItemsForTableViewParameters: (section: Int, Void)?
    var invokedNumberOfItemsForTableViewParametersList = [(section: Int, Void)]()
    var stubbedNumberOfItemsForTableViewResult: Int! = 0

    func numberOfItemsForTableView(for section: Int) -> Int {
        invokedNumberOfItemsForTableView = true
        invokedNumberOfItemsForTableViewCount += 1
        invokedNumberOfItemsForTableViewParameters = (section, ())
        invokedNumberOfItemsForTableViewParametersList.append((section, ()))
        return stubbedNumberOfItemsForTableViewResult
    }

    var invokedNumberOfItems = false
    var invokedNumberOfItemsCount = 0
    var invokedNumberOfItemsParameters: (section: Int, Void)?
    var invokedNumberOfItemsParametersList = [(section: Int, Void)]()
    var stubbedNumberOfItemsResult: Int! = 0

    func numberOfItems(for section: Int) -> Int {
        invokedNumberOfItems = true
        invokedNumberOfItemsCount += 1
        invokedNumberOfItemsParameters = (section, ())
        invokedNumberOfItemsParametersList.append((section, ()))
        return stubbedNumberOfItemsResult
    }

    var invokedSetLoading = false
    var invokedSetLoadingCount = 0
    var invokedSetLoadingParameters: (shouldLoad: Bool, Void)?
    var invokedSetLoadingParametersList = [(shouldLoad: Bool, Void)]()

    func setLoading(shouldLoad: Bool) {
        invokedSetLoading = true
        invokedSetLoadingCount += 1
        invokedSetLoadingParameters = (shouldLoad, ())
        invokedSetLoadingParametersList.append((shouldLoad, ()))
    }
}
