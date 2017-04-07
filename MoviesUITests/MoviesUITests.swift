//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Alexandre Malkov on 27/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import XCTest
import Alamofire

class MoviesUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        
//        let app = XCUIApplication()
//        let tablesQuery = app.tables
//        tablesQuery.staticTexts["Seeing the New Year In"].tap()
//        app.navigationBars["Episode details"].buttons["Home"].tap()
//
//        let bookmarksButton = app.navigationBars["Home"].buttons["Bookmarks"]
//        bookmarksButton.tap()
//
////        let bookmarksButton2 = app.navigationBars["Favorites"].buttons["Bookmarks"]
////        bookmarksButton2.tap()
////        tablesQuery.cells.containing(.staticText, identifier:"Bootle May Day Demonstration and Crowning of the May Queen (1903)").buttons["HeartOff"].tap()
////        bookmarksButton.tap()
////        bookmarksButton2.tap()
////        bookmarksButton.tap()
////        tablesQuery.cells.containing(.staticText, identifier:"Christmas Celebrations and the Cruel Cat").buttons["HeartOn"].tap()
////        tablesQuery.buttons["HeartOn"].tap()
////        bookmarksButton2.tap()
        
        
        
        let app = XCUIApplication()
        app.tables.staticTexts["Seeing the New Year In"].tap()
        app.navigationBars["Episode details"].buttons["Home"].tap()
        
        app.navigationBars["Home"].buttons["Bookmarks"].tap()
        app.navigationBars["Favorites"].buttons["Bookmarks"].tap()
        
        
    }
    
}
