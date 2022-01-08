//
//  UIViewController+Extension.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 5.01.2022.
//

import UIKit

extension UIViewController {

    static func initFromNib() -> Self {
        func instanceFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: nil)
        }
        return instanceFromNib()
    }

    func showError(
        title: String = "Error",
        message: String = "An error happened. Please try again later",
        preferredStyle: UIAlertController.Style = UIAlertController.Style.alert
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "Ok",
            style: .default
        ) { _ in
            alert.dismiss(animated: false, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
    }
}
