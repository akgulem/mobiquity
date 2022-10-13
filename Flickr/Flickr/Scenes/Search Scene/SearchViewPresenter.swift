//
//  SearchViewPresenter.swift
//  Flickr
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation
import Network

protocol SearchViewPresenterInterface: BaseViewPresenterInterface,
                                       TableViewPresenterInterface, CollectionViewPresenterInterface {

    func historyItemPresentation(for index: Int) -> String
    func saveHistoryItem(item: String)
    func clearSearchResults()
    func searchImages(with text: String)
    func cellPresentation(for indexPath: IndexPath) -> FlickrImageCollectionViewCellPresentation?
}

final class SearchViewPresenter {

    // MARK: VIPER variables
    private weak var view: SearchViewInterface?
    private let router: SearchViewRouterInterface?
    private let interactor: SearchViewInteractorInterface?

    // MARK: Presentations
    private var cellPresentations = [FlickrImageCollectionViewCellPresentation]()

    init(
        view: SearchViewInterface?,
        router: SearchViewRouterInterface?,
        interactor: SearchViewInteractorInterface?
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SearchViewPresenter: SearchViewPresenterInterface {

    func saveHistoryItem(item: String) {
        interactor?.saveSearchHistoryItem(item: item)
    }

    func historyItemPresentation(for index: Int) -> String {
        guard let result = interactor?.getSearchHistoryItem(at: index) else {
            return ""
        }
        return result
    }

    func numberOfItemsForTableView(for section: Int) -> Int {
        guard section == .zero else {
            return .zero
        }
        guard let numberOfHistoryItems = interactor?.numberOfHistoryItems() else {
            return .zero
        }
        return numberOfHistoryItems
    }

    func cellPresentation(for indexPath: IndexPath) -> FlickrImageCollectionViewCellPresentation? {
        guard indexPath.section == .zero else {
            return nil
        }
        return cellPresentations[indexPath.row]
    }

    func clearSearchResults() {
        cellPresentations.removeAll()
        interactor?.reset()
        view?.reloadCollectionView()
    }

    func searchImages(with text: String) {
        interactor?.search(with: text)
    }

    func viewDidLoad() {
        view?.prepareSearchBar()
        view?.prepareTableView()
        view?.prepareCollectionView()
        view?.preparePageTitle()
        view?.prepareNavigationBar()
    }

    func numberOfItems(for section: Int) -> Int {
        guard section == .zero else {
            return .zero
        }
        return cellPresentations.count
    }
}

extension SearchViewPresenter: SearchViewInteractorOutput {

    func handleDtoTransformation(result: Result<[PhotoDTO], ImageServiceError>) {
        switch result {
        case .success(let data):
            let cellPresentations = data.map {
                FlickrImageCollectionViewCellPresentation(
                    id: $0.id ?? "",
                    url: $0.getURL()
                )
            }
            self.cellPresentations.append(contentsOf: cellPresentations)
            view?.reloadCollectionView()
        case .failure(let error):
            switch error {
            case .photosCouldNotBeRetrieved:
                view?.showError(
                    title: "Error",
                    message: "Photos could not be retrieved. Try again later",
                    preferredStyle: .alert
                )
            case .photosReachedEnd:
                view?.showError(title: "Error", message: "There are no more photos", preferredStyle: .alert)
            }
        }
    }
}
