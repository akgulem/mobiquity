//
//  SearchViewController.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import UIKit

protocol SearchViewInterface: BaseViewInterface, CollectionViewInterface {

    func prepareSearchBar()
    func prepareCollectionView()
}

final class SearchViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var collectionView: UICollectionView!

    // MARK: Presenter
    var presenter: SearchViewPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SearchViewController: SearchViewInterface {

    func prepareSearchBar() {
        searchBar.delegate = self
    }

    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate {

}

extension SearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}

extension SearchViewController: UICollectionViewDelegate {

}
