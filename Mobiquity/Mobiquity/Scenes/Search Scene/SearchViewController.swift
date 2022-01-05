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

    private var searchHelper: SearchHelper!

    // MARK: Presenter
    var presenter: SearchViewPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SearchViewController: SearchViewInterface {

    func prepareSearchBar() {
        searchBar.delegate = self
        prepareSearchHelper()
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

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchHelper.handleTyping(text: searchText)
    }
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

// MARK: Helper Methods

private extension SearchViewController {

    func prepareSearchHelper() {
        searchHelper = SearchHelper { [weak self] text in
            guard let self = self else { return }
            self.presenter.clearSearchResults()
            self.presenter.searchImages(with: text)
        }
    }
}
