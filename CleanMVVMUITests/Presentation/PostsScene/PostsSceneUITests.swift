//
//  PostsSceneUITests.swift
//  CleanMVVMUITests
//
//  Created by SOSA PEREZ Cesar on 21/03/2021.
//

import XCTest

class PostsSceneUITests: XCTestCase {

    override func setUp() {

        continueAfterFailure = false
        XCUIApplication().launch()
    }

   
    func testOpenPostDetails_whenTapOnFirstResultRow_thenPostDetailsViewOpen() {
        
        let app = XCUIApplication()
        
        let searchText = "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
        let postDetailsTitle = "Post Details"
        // Tap on first result row
        app.tables.cells.staticTexts[searchText].tap()
        
        // Make sure post details view
        XCTAssertTrue(app.otherElements[AccessibilityIdentifier.postDetailsView].waitForExistence(timeout: 5))
        XCTAssertTrue(app.navigationBars[postDetailsTitle].waitForExistence(timeout: 5))
    }
}
