//
//  MockHomeRouter.swift
//  MoviesTests
//
//  Created by Mert Karadeniz on 4.05.2022.
//

@testable import Movies
import UIKit

final class MockHomeRouter: HomeRouterProtocol {
    var invokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: HomeRoutes, Void)?
    var invokedNavigateParametersList = [(route: HomeRoutes, Void)]()

    func navigate(_ route: HomeRoutes) {
        invokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
        invokedNavigateParametersList.append((route, ()))
    }
}
