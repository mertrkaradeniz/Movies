//
//  MockHomeViewController.swift
//  MoviesTests
//
//  Created by Mert Karadeniz on 4.05.2022.
//

@testable import Movies
import UIKit

final class MockHomeViewController: HomeViewControllerProtocol {
    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0

    func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }

    var invokedPrepareSearchTableView = false
    var invokedPrepareSearchTableViewCount = 0

    func prepareSearchTableView() {
        invokedPrepareSearchTableView = true
        invokedPrepareSearchTableViewCount += 1
    }

    var invokedPrepareSearchBar = false
    var invokedPrepareSearchBarCount = 0
    var invokedPrepareSearchBarParameters: (placeholder: String, Void)?
    var invokedPrepareSearchBarParametersList = [(placeholder: String, Void)]()

    func prepareSearchBar(_ placeholder: String) {
        invokedPrepareSearchBar = true
        invokedPrepareSearchBarCount += 1
        invokedPrepareSearchBarParameters = (placeholder, ())
        invokedPrepareSearchBarParametersList.append((placeholder, ()))
    }

    var invokedShowNavigationBar = false
    var invokedShowNavigationCount = 0

    func showNavigationBar(_ animated: Bool) {
        invokedShowNavigationBar = true
        invokedShowNavigationCount += 1
    }

    var invokedHideNavigationBar = false
    var invokedHideNavigationCount = 0

    func hideNavigationBar(_ animated: Bool) {
        invokedHideNavigationBar = true
        invokedHideNavigationCount += 1
    }

    var invokedShowLoadingView = false
    var invokedShowLoadingViewCount = 0

    func showLoadingView() {
        invokedShowLoadingView = true
        invokedShowLoadingViewCount += 1
    }

    var invokedHideLoadingView = false
    var invokedHideLoadingViewCount = 0

    func hideLoadingView() {
        invokedHideLoadingView = true
        invokedHideLoadingViewCount += 1
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }

    var invokedSearchReloadData = false
    var invokedSearchReloadDataCount = 0

    func searchReloadData() {
        invokedSearchReloadData = false
        invokedSearchReloadDataCount += 1
    }
}
