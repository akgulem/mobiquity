//
//  SearchViewRouter.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import UIKit

protocol SearchViewRouterInterface {

}

final class SearchViewRouter {

    weak var navigationController: UINavigationController?

    init(with navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    static func createModule(using navigationController: UINavigationController? = nil) -> SearchViewController {
        let view = SearchViewController.initFromNib()
        let router = SearchViewRouter(with: navigationController)
        let interactor = SearchViewInteractor()

        let presenter = SearchViewPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }
}

extension SearchViewRouter: SearchViewRouterInterface {
}
