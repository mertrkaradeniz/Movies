//
//  HomeRouter.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import Foundation

enum HomeRoutes {
    case movieDetail(movie: Movie)
}

protocol HomeRouterProtocol: AnyObject {
    func navigate(_ route: HomeRoutes)
}

final class HomeRouter {
    private weak var viewController: HomeViewController?

    static func setupModule() -> HomeViewController {
        let homeVC = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor, router: router, view: homeVC)

        homeVC.presenter = presenter
        interactor.output = presenter
        router.viewController = homeVC
        return homeVC
    }
}

extension HomeRouter: HomeRouterProtocol {
    func navigate(_ route: HomeRoutes) {
        switch route {
        case .movieDetail(movie: let movie):
            let movieDetailVC = MovieDetailRouter.setupModule()
            movieDetailVC.movie = movie
            viewController?.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
}
