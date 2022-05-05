//
//  HomePresenterTests.swift
//  MoviesTests
//
//  Created by Mert Karadeniz on 4.05.2022.
//

@testable import Movies
import XCTest

class HomePresenterTests: XCTestCase {
    var presenter: HomePresenter!
    var view: MockHomeViewController!
    var interactor: MockHomeInteractor!
    var router: MockHomeRouter!

    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(interactor: interactor, router: router, view: view)
    }

    func test_viewDidLoad_InvokedsRequiredViewMethods() {
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertEqual(view.invokedPrepareTableViewCount, 0)
        XCTAssertFalse(view.invokedPrepareSearchTableView)
        XCTAssertEqual(view.invokedPrepareSearchTableViewCount, 0)
        XCTAssertFalse(view.invokedPrepareSearchBar)
        XCTAssertEqual(view.invokedPrepareSearchBarCount, 0)
        XCTAssertNil(view.invokedPrepareSearchBarParameters)
        XCTAssertFalse(interactor.invokedFetchNowPlaying)
        XCTAssertEqual(interactor.invokedFetchNowPlayingCount, 0)
        XCTAssertFalse(interactor.invokedFetchUpcomingMovies)
        XCTAssertEqual(interactor.invokedFetchUpcomingMoviesCount, 0)

        presenter.viewDidLoad()

        XCTAssertTrue(view.invokedPrepareTableView)
        XCTAssertEqual(view.invokedPrepareTableViewCount, 1)
        XCTAssertTrue(view.invokedPrepareSearchTableView)
        XCTAssertEqual(view.invokedPrepareSearchTableViewCount, 1)
        XCTAssertTrue(view.invokedPrepareSearchBar)
        XCTAssertEqual(view.invokedPrepareSearchBarCount, 1)
        XCTAssertEqual(view.invokedPrepareSearchBarParameters?.placeholder, "Search Movie")
        XCTAssertNotNil(view.invokedPrepareSearchBarParameters)
        XCTAssertTrue(interactor.invokedFetchUpcomingMovies)
        XCTAssertEqual(interactor.invokedFetchUpcomingMoviesCount, 1)
    }

    func test_numberOfItems_ReturnItemCount() {
        presenter.fetchUpcomingMoviesOutput(result: .success(.response))
        XCTAssertEqual(presenter.numberOfObjects, 20)
    }

    func test_numberOfItems_NilResponse_ReturnItemCount() {
        XCTAssertEqual(presenter.numberOfObjects, 0)
    }

    func test_upcomingMoviesWithValidData() {
        presenter.fetchUpcomingMoviesOutput(result: .success(.response))
        XCTAssertNotNil(presenter.getMovie(_: 1))
    }

    func test_upcomingMoviesWithInvalidData() {
        XCTAssertNil(presenter.getMovie(_: 1))
    }

    func test_didSelectItemAtWithValidData() {
        XCTAssertFalse(router.invokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 0)

        presenter.fetchUpcomingMoviesOutput(result: .success(.response))
        presenter.didSelectRowAt(index: 1)

        XCTAssertTrue(router.invokedNavigate)
        XCTAssertEqual(router.invokedNavigateCount, 1)
    }

    func test_searchMovies() {
        XCTAssertFalse(interactor.invokedFetchSearchedMovies)
        XCTAssertEqual(interactor.invokedFetchSearchedMoviesCount, 0)
        XCTAssertNil(interactor.invokedFetchSearchedMoviesParameters?.query)

        presenter.searchMovies(with: "Joker")

        XCTAssertTrue(interactor.invokedFetchSearchedMovies)
        XCTAssertEqual(interactor.invokedFetchSearchedMoviesCount, 1)
        XCTAssertEqual(interactor.invokedFetchSearchedMoviesParameters?.query, "Joker")
        XCTAssertEqual(interactor.invokedFetchSearchedMoviesParameters?.page, 1)
    }

    func test_fetchUpcomingMoviesOutput() {
        XCTAssertFalse(view.invokedShowLoadingView)
        XCTAssertEqual(view.invokedShowLoadingViewCount, 0)
        XCTAssertFalse(view.invokedHideLoadingView)
        XCTAssertEqual(view.invokedHideNavigationCount, 0)
        XCTAssertEqual(presenter.numberOfObjects, 0)
        XCTAssertNil(presenter.getMovie(_: 0))
        XCTAssertFalse(view.invokedReloadData)

        view?.showLoadingView()
        presenter.fetchUpcomingMoviesOutput(result: .success(.response))
        view?.hideLoadingView()

        XCTAssertTrue(view.invokedShowLoadingView)
        XCTAssertTrue(view.invokedHideLoadingView)
        XCTAssertNotNil(presenter.getMovie(_: 1))
        XCTAssertTrue(view.invokedReloadData)
        XCTAssertEqual(presenter.numberOfObjects, 20)
    }
}

extension BaseReponse {
    // swiftlint:disable all
    static var response: BaseReponse {
        
        let bundle = Bundle(for: HomePresenterTests.self)
        let path = bundle.path(forResource: "MoviesResponse", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let baseResponse = try! JSONDecoder().decode(BaseReponse.self, from: data)
        return baseResponse
    }
    // swiftlint:enable all

    static var emptyResponse: BaseReponse? {
        nil
    }
}
