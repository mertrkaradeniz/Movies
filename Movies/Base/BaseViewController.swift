//
//  BaseViewController.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import UIKit

class BaseViewController: UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default, handler: .none)
        alert.addAction(actionOk)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })
    }
}
