//
//  SplashPresenter.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import Foundation

protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}

final class SplashPresenter {
    private weak var view: SplashViewControllerProtocol?
    private let router: SplashRouterProtocol?
    private let interactor: SplashInteractorProtocol?

    init(interactor: SplashInteractorProtocol, router: SplashRouterProtocol, view: SplashViewControllerProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SplashPresenter: SplashPresenterProtocol {
    func viewDidAppear() {
        interactor?.checkInternetConnection()
    }
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    func internetConnection(status: Bool) {
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.router?.navigate(.homeScreen)
            }
        } else {
            view?.noNetworkConnection()
        }
    }
}
