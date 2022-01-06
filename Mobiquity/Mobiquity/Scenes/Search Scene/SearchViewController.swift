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

struct CollectionViewFlowLayoutParameters {

    var topInset: CGFloat = .zero
    var leftInset: CGFloat = 10.0
    var rightInset: CGFloat = 10.0
    var bottomInset: CGFloat = .zero

    var minimumInterItemSpace: CGFloat = 5.0
    var minimumLineSpace: CGFloat = .zero
    var cellHeight: CGFloat = 300.0
    var numberOfItemsPerRow: CGFloat = 2
}

final class SearchViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var collectionView: UICollectionView!
    private var collectionViewParameters = CollectionViewFlowLayoutParameters()

    private var searchHelper: SearchHelper!

    // MARK: Presenter
    var presenter: SearchViewPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension SearchViewController: SearchViewInterface {

    func prepareSearchBar() {
        searchBar.placeholder = "Search images"
        searchBar.delegate = self
        prepareSearchHelper()
    }

    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: FlickrImageCollectionViewCell.self, bundle: nil)
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

// MARK: UIScrollViewDelegate methods

extension SearchViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(false)
    }
}

// MARK: UICollectionViewDelegateFlowLayout Methods

extension SearchViewController: UICollectionViewDelegateFlowLayout {

    private var collectionViewWidth: CGFloat {
        let margins = collectionViewParameters.leftInset +
                    collectionViewParameters.rightInset +
                    collectionViewParameters.minimumInterItemSpace
        return (collectionView.frame.size.width - margins) / collectionViewParameters.numberOfItemsPerRow
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionViewWidth, height: collectionViewParameters.cellHeight)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let insets = UIEdgeInsets(
            top: .zero,
            left: collectionViewParameters.leftInset,
            bottom: .zero,
            right: collectionViewParameters.rightInset
        )
        return insets
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return .zero
    }
}

extension SearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems(for: section)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard indexPath.section == .zero else {
            return UICollectionViewCell()
        }

        guard let flickrImageCell = collectionView.dequeueReusableCell(
            with: FlickrImageCollectionViewCell.self,
            for: indexPath
        ) else {
            return UICollectionViewCell()
        }
        let presentation = presenter.cellPresentation(for: indexPath)
        flickrImageCell.setupUI(presentation: presentation, indexPath: indexPath)
        return flickrImageCell
    }
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
