//
//  SplashRouter.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import UIKit

enum SplashRoutes {
    case homeScreen
}

protocol SplashRouterProtocol: AnyObject {
    func navigate(_ route: SplashRoutes)
}

final class SplashRouter {
    private weak var viewController: SplashViewController?

    static func setupModule() -> SplashViewController {
        let splashVC = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(interactor: interactor, router: router, view: splashVC)
        splashVC.presenter = presenter
        interactor.output = presenter
        router.viewController = splashVC
        return splashVC
    }
}

extension SplashRouter: SplashRouterProtocol {
    func navigate(_ route: SplashRoutes) {
        switch route {
        case .homeScreen:
            guard let window = viewController?.view.window else { return }
            let viewController = HomeRouter.setupModule()
            let navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
        }
    }
}
