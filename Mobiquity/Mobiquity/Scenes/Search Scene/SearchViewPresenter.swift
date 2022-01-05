//
//  SearchViewPresenter.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation

protocol SearchViewPresenterInterface: BaseViewPresenterInterface, CollectionViewPresenterInterface {

    func clearSearchResults()
    func searchImages(with text: String)
}

final class SearchViewPresenter {

    // MARK: VIPER variables
    private weak var view: SearchViewInterface?
    private let router: SearchViewRouterInterface?
    private let interactor: SearchViewInteractorInterface?

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

    func clearSearchResults() {
    }

    func searchImages(with text: String) {
    }

    func viewDidLoad() {

    }

    func numberOfItems(for section: Int) -> Int {
        .zero
    }
}

extension SearchViewPresenter: SearchViewInteractorOutput {
}
