//
//  HomePresenter.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    var numberOfObjects: Int { get }
    var numberOfSearchedMovies: Int { get }
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func getMovie(_ index: Int) -> Any?
    func getSliderMovie(_ index: Int) -> Movie?
    func getSearchedMovie(_ index: Int) -> Movie?
    func didSelectRowAt(index: Int)
    func didSelectSliderRowAt(index: Int)
    func didSelectSearchRowAt(index: Int)
    func searchMovies(with query: String)
}

final class HomePresenter {
    private weak var view: HomeViewControllerProtocol?
    private let router: HomeRouterProtocol?
    private let interactor: HomeInteractorProtocol?

    private var upcomingMovies: [Movie] = []
    private var nowPlayingMovies: [Movie] = []
    private var searchedMovies: [Movie] = []
    private var objects: [Any] = []

    private var currentPage = 1

    init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol, view: HomeViewControllerProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomePresenterProtocol {
    var numberOfSearchedMovies: Int {
        searchedMovies.count
    }

    var numberOfObjects: Int {
        objects.count
    }

    func viewDidLoad() {
        view?.prepareSearchBar("Search Movie")
        view?.prepareTableView()
        view?.prepareSearchTableView()
        fetchUpcomingAndNowPlayingMovies()
    }

    func viewWillAppear(_ animated: Bool) {
        view?.hideNavigationBar(animated)
    }

    func viewWillDisappear(_ animated: Bool) {
        view?.showNavigationBar(animated)
    }

    private func fetchUpcomingAndNowPlayingMovies() {
        view?.showLoadingView()
        interactor?.fetchUpcomingMovies()
    }

    func getMovie(_ index: Int) -> Any? {
        objects[safe: index]
    }

    func getSearchedMovie(_ index: Int) -> Movie? {
        searchedMovies[safe: index]
    }

    func getSliderMovie(_ index: Int) -> Movie? {
        nowPlayingMovies[safe: index]
    }

    func didSelectRowAt(index: Int) {
        guard let movie = getMovie(index) as? Movie else { return }
        router?.navigate(.movieDetail(movie: movie))
    }

    func didSelectSliderRowAt(index: Int) {
        guard let movie = getSliderMovie(index) else { return }
        router?.navigate(.movieDetail(movie: movie))
    }

    func didSelectSearchRowAt(index: Int) {
        guard let movie = getSearchedMovie(index) else { return }
        router?.navigate(.movieDetail(movie: movie))
    }

    func searchMovies(with query: String) {
        interactor?.fetchSearchedMovies(query: query, page: currentPage)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func fetchNowPlayingMoviesOutput(result: MoviesResult) {
        view?.hideLoadingView()
        switch result {
        case .success(let moviesResult):
            guard let result = moviesResult.results else { return }
            nowPlayingMovies = result
            objects.insert(nowPlayingMovies, at: 0)
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }

    func fetchUpcomingMoviesOutput(result: MoviesResult) {
        switch result {
        case .success(let moviesResult):
            interactor?.fetchNowPlaying()
            guard let result = moviesResult.results else { return }
            upcomingMovies = result
            objects += upcomingMovies
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }

    func fetchSearchedMoviesOutput(result: MoviesResult) {
        switch result {
        case .success(let moviesResult):
            searchedMovies = moviesResult.results!
            view?.searchReloadData()
        case .failure(let error):
            print(error)
        }
    }
}
