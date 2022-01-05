//
//  BaseInteractorOutput.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation

protocol BaseInteractorOutput: AnyObject {

    func setLoading(shouldLoad: Bool)
}

extension BaseInteractorOutput {

    func setLoading(shouldLoad: Bool) {
    }
}
