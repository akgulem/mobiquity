//
//  MockSearchViewInteractor.swift
//  AdyenTests
//
//  Created by Emrah Akgül on 4.01.2022.
//

import Foundation
@testable import Mobiquity

final class MockSearchViewInteractor: SearchViewInteractorInterface {

    var invokedNumberOfHistoryItems = false
    var invokedNumberOfHistoryItemsCount = 0
    var stubbedNumberOfHistoryItemsResult: Int! = 0

    var invokedGetSearchHistoryItem = false
    var invokedGetSearchHistoryItemCount = 0
    var invokedGetSearchHistoryItemParameters: (index: Int, Void)?
    var invokedGetSearchHistoryItemParametersList = [(index: Int, Void)]()
    var stubbedGetSearchHistoryItemResult: String! = ""

    var invokedSaveSearchHistoryItem = false
    var invokedSaveSearchHistoryItemCount = 0
    var invokedSaveSearchHistoryItemParameters: (item: String, Void)?
    var invokedSaveSearchHistoryItemParametersList = [(item: String, Void)]()

    var invokedSearch = false
    var invokedSearchCount = 0
    var invokedSearchParameters: (text: String, Void)?
    var invokedSearchParametersList = [(text: String, Void)]()

    var invokedReset = false
    var invokedResetCount = 0

    func numberOfHistoryItems() -> Int {
        invokedNumberOfHistoryItems = true
        invokedNumberOfHistoryItemsCount += 1
        return stubbedNumberOfHistoryItemsResult
    }

    func reset() {
        invokedReset = true
        invokedResetCount += 1
    }

    func search(with text: String) {
        invokedSearch = true
        invokedSearchCount += 1
        invokedSearchParameters = (text, ())
        invokedSearchParametersList.append((text, ()))
    }

    func saveSearchHistoryItem(item: String) {
        invokedSaveSearchHistoryItem = true
        invokedSaveSearchHistoryItemCount += 1
        invokedSaveSearchHistoryItemParameters = (item, ())
        invokedSaveSearchHistoryItemParametersList.append((item, ()))
    }

    func getSearchHistoryItem(at index: Int) -> String {
        invokedGetSearchHistoryItem = true
        invokedGetSearchHistoryItemCount += 1
        invokedGetSearchHistoryItemParameters = (index, ())
        invokedGetSearchHistoryItemParametersList.append((index, ()))
        return stubbedGetSearchHistoryItemResult
    }
}
