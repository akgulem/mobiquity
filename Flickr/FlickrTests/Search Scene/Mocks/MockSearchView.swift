//
//  MockSearchView.swift
//  AdyenTests
//
//  Created by Emrah Akgül on 4.01.2022.
//

import Foundation
import UIKit
@testable import Flickr

final class MockSearchView: SearchViewInterface {

    var invokedPrepareSearchBar = false
    var invokedPrepareSearchBarCount = 0

    var invokedPrepareCollectionView = false
    var invokedPrepareCollectionViewCount = 0

    var invokedPreparePageTitle = false
    var invokedPreparePageTitleCount = 0

    var invokedPrepareNavigationBar = false
    var invokedPrepareNavigationBarCount = 0

    var invokedShowError = false
    var invokedShowErrorCount = 0
    // swiftlint:disable large_tuple
    var invokedShowErrorParameters: (title: String, message: String, preferredStyle: UIAlertController.Style)?
    var invokedShowErrorParametersList = [(title: String, message: String, preferredStyle: UIAlertController.Style)]()

    func showError(
        title: String,
        message: String,
        preferredStyle: UIAlertController.Style
    ) {
        invokedShowError = true
        invokedShowErrorCount += 1
        invokedShowErrorParameters = (title, message, preferredStyle)
        invokedShowErrorParametersList.append((title, message, preferredStyle))
    }

    var invokedReloadTableView = false
    var invokedReloadTableViewCount = 0

    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0

    var invokedReloadCollectionView = false
    var invokedReloadCollectionViewCount = 0

    func preparePageTitle() {
        invokedPreparePageTitle = true
        invokedPreparePageTitleCount += 1
    }

    func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }

    func reloadTableView() {
        invokedReloadTableView = true
        invokedReloadTableViewCount += 1
    }

    func prepareNavigationBar() {
        invokedPrepareNavigationBar = true
        invokedPrepareNavigationBarCount += 1
    }

    func prepareSearchBar() {
        invokedPrepareSearchBar = true
        invokedPrepareSearchBarCount += 1
    }

    func prepareCollectionView() {
        invokedPrepareCollectionView = true
        invokedPrepareCollectionViewCount += 1
    }

    func reloadCollectionView() {
        invokedReloadCollectionView = true
        invokedReloadCollectionViewCount += 1
    }
}
