//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import XCTest

final class MoviesUITests: XCTestCase {

    private let app = XCUIApplication()

    func testSearchMovie() {
        app.launch()

        let searchField = app.searchFields["Search Movie"]
        let firstSearchCellLabel = app.tables["searchTableViewIdentifier"].staticTexts["searchCellLabel_0"]

        searchField.tap()
        let jKey = app.keys["J"]
        jKey.tap()
        let oKey = app.keys["o"]
        oKey.tap()
        let kKey = app.keys["k"]
        kKey.tap()
        let eKey = app.keys["e"]
        eKey.tap()
        let rKey = app.keys["r"]
        rKey.tap()

        XCTAssertTrue(searchField.exists)
        XCTAssertTrue(firstSearchCellLabel.exists)
        XCTAssertEqual(firstSearchCellLabel.label, "Joker")
    }

    func testMovieTableView() {
        app.launch()
        let firstCellLabel = app.tables["tableViewIdentifier"].staticTexts["movieCell_2"]

        firstCellLabel.tap()
        XCTAssertTrue(firstCellLabel.exists)
        XCTAssertEqual(firstCellLabel.label, "Doctor Strange in the Multiverse of Madness")
    }

    func testMovieSlider() {
        app.launch()

        let tableviewidentifierTable = app.tables["tableViewIdentifier"]
        let firtMovieCell = tableviewidentifierTable.staticTexts["movieCell_1"]
        firtMovieCell.tap()

        XCTAssertTrue(firtMovieCell.exists)
    }
}
