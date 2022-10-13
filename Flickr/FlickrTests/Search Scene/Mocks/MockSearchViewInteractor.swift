//
//  MockSearchViewInteractor.swift
//  AdyenTests
//
//  Created by Emrah Akgül on 4.01.2022.
//

import Foundation
@testable import Flickr

final class MockSearchViewInteractor: SearchViewInteractorInterface {

    var invokedOutputGetter = false
    var invokedOutputGetterCount = 0
    var stubbedOutput: SearchViewInteractorOutput!

    var output: SearchViewInteractorOutput? {
        invokedOutputGetter = true
        invokedOutputGetterCount += 1
        return stubbedOutput
    }

    var invokedNumberOfHistoryItems = false
    var invokedNumberOfHistoryItemsCount = 0
    var stubbedNumberOfHistoryItemsResult: Int! = 0

    func numberOfHistoryItems() -> Int {
        invokedNumberOfHistoryItems = true
        invokedNumberOfHistoryItemsCount += 1
        return stubbedNumberOfHistoryItemsResult
    }

    var invokedGetSearchHistoryItem = false
    var invokedGetSearchHistoryItemCount = 0
    var stubbedGetSearchHistoryItemResult: String! = ""

    func getSearchHistoryItem(at index: Int) -> String {
        invokedGetSearchHistoryItem = true
        invokedGetSearchHistoryItemCount += 1
        return stubbedGetSearchHistoryItemResult ?? ""
    }

    var invokedSaveSearchHistoryItem = false
    var invokedSaveSearchHistoryItemCount = 0
    var invokedSaveSearchHistoryItemParameters: (item: String, Void)?

    func saveSearchHistoryItem(item: String) {
        invokedSaveSearchHistoryItem = true
        invokedSaveSearchHistoryItemCount += 1
        invokedSaveSearchHistoryItemParameters = (item, ())
    }

    var invokedSearch = false
    var invokedSearchCount = 0
    var invokedSearchParameters: (text: String, Void)?
    var invokedSearchParametersList = [(text: String, Void)]()

    func search(with text: String) {
        invokedSearch = true
        invokedSearchCount += 1
        invokedSearchParameters = (text, ())
        invokedSearchParametersList.append((text, ()))
    }

    var invokedReset = false
    var invokedResetCount = 0

    func reset() {
        invokedReset = true
        invokedResetCount += 1
    }
}
