//
//  NYTimesArticlesAppUITests.swift
//  NYTimesArticlesAppUITests
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import XCTest
@testable import NYTimesArticlesApp
class NYTimesArticlesAppUITests: XCTestCase {
    
    
    func testTitleMatchBetweenListAndDetail() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Access and store the title of the first cell
        let firstCellTitleElement = app.staticTexts["cell_title"].firstMatch
        XCTAssertTrue(firstCellTitleElement.waitForExistence(timeout: 5.0), "The first cell's title did not appear in time")
        
        let cellTitle = firstCellTitleElement.label
        
        // Tap to navigate
        let firstCell = app.cells["cell_0"]
        XCTAssertTrue(firstCell.exists, "The first cell does not exist")
        firstCell.tap()
        
        // wait
        let detailViewTitleElement = app.staticTexts["article_title"]
        XCTAssertTrue(detailViewTitleElement.waitForExistence(timeout: 10.0), "The article title on the detail page did not appear in time")
        
        let detailViewTitle = detailViewTitleElement.label
        
        // Compare the titles
        XCTAssertEqual(cellTitle, detailViewTitle, "The title on the detail page does not match the title in the cell")
        
    }
    
}
