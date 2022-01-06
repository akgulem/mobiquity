//
//  SearchViewPresenter.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation
import Network

struct CellPresentation: Hashable {

    let id: String
    let url: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

protocol SearchViewPresenterInterface: BaseViewPresenterInterface, CollectionViewPresenterInterface {

    func clearSearchResults()
    func searchImages(with text: String)
}

final class SearchViewPresenter {

    // MARK: VIPER variables
    private weak var view: SearchViewInterface?
    private let router: SearchViewRouterInterface?
    private let interactor: SearchViewInteractorInterface?

    var cellPresentations = [CellPresentation]()

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
        interactor?.search(with: text)
    }

    func viewDidLoad() {
        view?.prepareSearchBar()
        view?.prepareCollectionView()
        view?.preparePageTitle()
        view?.prepareNavigationBar()
    }

    func numberOfItems(for section: Int) -> Int {
        .zero
    }
}

extension SearchViewPresenter: SearchViewInteractorOutput {

    func handleDtoTransformation(result: Result<[PhotoDTO], ImageServiceError>) {
        switch result {
        case .success(let data):
            let cellPresentations = data.map { CellPresentation(id: $0.id ?? "", url: $0.getURL())}
            self.cellPresentations.append(contentsOf: cellPresentations)
        case .failure(let error):
            switch error {
            case .photosCouldNotBeRetrieved:
                break
            case .photosReachedEnd:
                break
            }
        }
    }
}
