//
//  SearchViewInteractor.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation

protocol SearchViewInteractorInterface {
}

protocol SearchViewInteractorOutput: BaseInteractorOutput {
}

final class SearchViewInteractor {

    weak var output: SearchViewInteractorOutput?
}

extension SearchViewInteractor: SearchViewInteractorInterface {

}
