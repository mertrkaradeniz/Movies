//
//  SplashViewController.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noNetworkConnection()
}

final class SplashViewController: BaseViewController {
    var presenter: SplashPresenterProtocol?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
}

extension SplashViewController: SplashViewControllerProtocol {
    func noNetworkConnection() {
        showAlert(title: "Error", message: "No internet connection")
    }
}
