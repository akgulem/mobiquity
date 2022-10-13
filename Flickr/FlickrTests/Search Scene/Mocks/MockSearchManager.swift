//
//  MockSearchManager.swift
//  FlickrTests
//
//  Created by Emrah Akgül on 7.01.2022.
//

import Foundation
import Network
@testable import Flickr

final class MockSearchManager: SearchManageable {

    var invokedNumberOfSearchHistoriesGetter = false
    // swiftlint:disable identifier_name
    var invokedNumberOfSearchHistoriesGetterCount = 0
    var stubbedNumberOfSearchHistories: Int! = 0

    var numberOfSearchHistories: Int {
        invokedNumberOfSearchHistoriesGetter = true
        invokedNumberOfSearchHistoriesGetterCount += 1
        return stubbedNumberOfSearchHistories
    }

    var invokedGetSearchHistoryItem = false
    var invokedGetSearchHistoryItemCount = 0
    var invokedGetSearchHistoryItemParameters: (index: Int, Void)?
    // swiftlint:disable identifier_name
    var invokedGetSearchHistoryItemParametersList = [(index: Int, Void)]()
    var stubbedGetSearchHistoryItemResult: String! = ""

    func getSearchHistoryItem(at index: Int) -> String {
        invokedGetSearchHistoryItem = true
        invokedGetSearchHistoryItemCount += 1
        invokedGetSearchHistoryItemParameters = (index, ())
        invokedGetSearchHistoryItemParametersList.append((index, ()))
        return stubbedGetSearchHistoryItemResult
    }

    var invokedSaveSearchHistoryItem = false
    var invokedSaveSearchHistoryItemCount = 0
    var invokedSaveSearchHistoryItemParameters: (item: String, Void)?
    // swiftlint:disable identifier_name
    var invokedSaveSearchHistoryItemParametersList = [(item: String, Void)]()

    func saveSearchHistoryItem(item: String) {
        invokedSaveSearchHistoryItem = true
        invokedSaveSearchHistoryItemCount += 1
        invokedSaveSearchHistoryItemParameters = (item, ())
        invokedSaveSearchHistoryItemParametersList.append((item, ()))
    }
}
