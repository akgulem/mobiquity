//
//  SearchViewController.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import UIKit

protocol SearchViewInterface: BaseViewInterface, CollectionViewInterface {
}

final class SearchViewController: UIViewController {

    // MARK: Presenter
    var presenter: SearchViewPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SearchViewController: SearchViewInterface {

    func prepareCollectionView() {
    }

    func reloadCollectionView() {
    }
}
