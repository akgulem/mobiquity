//
//  SearchViewController.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import UIKit

protocol SearchViewInterface: BaseViewInterface, TableViewInterface, CollectionViewInterface {

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
    @IBOutlet private var historyTableView: UITableView!
    private var collectionViewParameters = CollectionViewFlowLayoutParameters()

    // MARK: Helpers
    private var searchHelper: SearchHelper!

    // MARK: Variables
    private var shouldShowHistoryTableView = false {
        didSet {
            historyTableView.isHidden = !shouldShowHistoryTableView
            if shouldShowHistoryTableView {
                reloadTableView()
            }
        }
    }

    // MARK: Presenter
    var presenter: SearchViewPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension SearchViewController: SearchViewInterface {

    func reloadTableView() {
        historyTableView.reloadData()
    }

    func prepareTableView() {
        historyTableView.dataSource = self
        historyTableView.delegate = self
    }

    func prepareNavigationBar() {
        title = "Search"
    }

    func prepareSearchBar() {
        searchBar.placeholder = "Search images"
        searchBar.delegate = self
        prepareSearchHelper()
    }

    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: FlickrImageCollectionViewCell.self, bundle: nil)
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

// MARK: UISearchBarDelegate methods

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchHelper.handleTyping(text: searchText)
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        shouldShowHistoryTableView = true
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        shouldShowHistoryTableView = true
        search(text: searchBar.text ?? "")
    }
}

// MARK: UIScrollViewDelegate methods

extension SearchViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is UICollectionView {
            searchBar.endEditing(false)
            guard let text = searchBar.text else {
                return
            }
            presenter.saveHistoryItem(item: text)
        }
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

// MARK: UICollectionViewDataSource Methods

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

// MARK: UICollectionViewPrefetching Methods

extension SearchViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let lastIndex = indexPaths.last?.item, lastIndex == presenter.numberOfItems(for: .zero) - 1 else {
            return
        }

        guard let text = searchBar.text else {
            presenter.searchImages(with: "")
            return
        }
        presenter.searchImages(with: text)
    }
}

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItemsForTableView(for: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = presenter.historyItemPresentation(for: indexPath.row)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let text = presenter.historyItemPresentation(for: indexPath.item)
        searchBar.text = text
        search(text: searchBar.text ?? "")
    }
}

// MARK: Helper Methods

private extension SearchViewController {

    func prepareSearchHelper() {
        searchHelper = SearchHelper { [weak self] text in
            guard let self = self else { return }
            self.search(text: text)
        }
    }

    func search(text: String) {
        guard !text.isEmpty else {
            return
        }
        shouldShowHistoryTableView = false
        presenter.clearSearchResults()
        presenter.searchImages(with: text)
        presenter.saveHistoryItem(item: text)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize =
            (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
           !historyTableView.isHidden {
            historyTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if !historyTableView.isHidden {
            historyTableView.contentInset = .zero
        }
    }
}
