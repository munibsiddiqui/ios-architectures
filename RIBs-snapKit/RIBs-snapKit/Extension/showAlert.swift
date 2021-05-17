//
//  showAlert.swift
//  RIBs-snapKit
//
//  Created by GoEun Jeong on 2021/05/16.
//

import UIKit

extension UIViewController {
    func showErrorAlert(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil,
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default))
            self.present(alert, animated: true)
        }
    }
}
