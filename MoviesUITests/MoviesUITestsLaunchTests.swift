//
//  MoviesUITestsLaunchTests.swift
//  MoviesUITests
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import XCTest

class MoviesUITestsLaunchTests: XCTestCase {
    
    let app = XCUIApplication()
    
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
        let firstCellLabel = app.tables["tableViewIdentifier"].staticTexts["movieCell_1"]
        
        firstCellLabel.tap()
        XCTAssertTrue(firstCellLabel.exists)
        XCTAssertEqual(firstCellLabel.label, "The Outfit")
    }
    
    func testMovieSlider() {
        app.launch()
    
        let tableviewidentifierTable = app.tables["tableViewIdentifier"]
        let firtCell = tableviewidentifierTable.staticTexts["movieCell_1"]
        firtCell.tap()

        XCTAssertTrue(firtCell.exists)
    }

}
