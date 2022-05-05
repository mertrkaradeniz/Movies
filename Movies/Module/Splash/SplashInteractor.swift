//
//  SplashInteractor.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import Foundation

protocol SplashInteractorProtocol: AnyObject {
    func checkInternetConnection()
}

protocol SplashInteractorOutputProtocol: AnyObject {
    func internetConnection(status: Bool)
}

final class SplashInteractor: SplashInteractorProtocol {
    var output: SplashInteractorOutputProtocol?

    func checkInternetConnection() {
        let internetConnectionStatus = NetworkManager.shared.networkIsReachable
        self.output?.internetConnection(status: internetConnectionStatus)
    }
}
