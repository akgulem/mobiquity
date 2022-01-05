//
//  SearchViewInteractor.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation
import Network

protocol SearchViewInteractorInterface {

    func search(with text: String)
    func reset()
}

protocol SearchViewInteractorOutput: BaseInteractorOutput {
}

final class SearchViewInteractor {

    weak var output: SearchViewInteractorOutput?
    private var searchImagesService: SearchImagesServiceProtocol

    init(searchImagesService: SearchImagesServiceProtocol) {
        self.searchImagesService = searchImagesService
    }
}

extension SearchViewInteractor: SearchViewInteractorInterface {

    func search(with text: String) {
    }

    func reset() {
    }
}
