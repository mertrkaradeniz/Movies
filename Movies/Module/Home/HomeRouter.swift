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
        let vc = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interactor: interactor, router: router, view: vc)
        
        vc.presenter = presenter
        interactor.output = presenter
        router.viewController = vc
        return vc
    }
}

extension HomeRouter: HomeRouterProtocol {
    func navigate(_ route: HomeRoutes) {
        switch route {
        case .movieDetail(movie: let movie):
            let vc = MovieDetailRouter.setupModule()
            vc.movie = movie
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
