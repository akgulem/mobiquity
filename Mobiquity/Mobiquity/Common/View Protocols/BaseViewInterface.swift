//
//  BaseViewInterface.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation
import UIKit

protocol BaseViewInterface: AnyObject {

    func preparePageTitle()
    func prepareNavigationBar()
    func showError(
        title: String,
        message: String,
        preferredStyle: UIAlertController.Style
    )
}

extension BaseViewInterface {

    func preparePageTitle() { }
    func prepareNavigationBar() { }

    func showError(title: String, message: String, preferredStyle: UIAlertController.Style = .alert) {
        if let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
           let rootVC = keyWindow.rootViewController {
            rootVC.showError(title: title, message: message, preferredStyle: preferredStyle)
        }
    }
}
