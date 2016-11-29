//
//  PresenterTests.swift
//  Movies
//
//  Created by Alexandre Malkov on 28/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import XCTest
@testable import Movies

class PresenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Clear all data
        Schedule.deleteAll()
        Film.deleteAll()
        Favorite.deleteAll()

        // Load JSON file
        let fileName = "Home"
        let json = TestsHelper.readJsonFile(fileName)
        Schedule.loadFromJson(jsonString: json)
        
        // Add favorites with film data
        for uid in ["film_a5e1022dfd874e169fd6da6597d0cd0f", "film_f3018fc67bcc46eda60deeb5ec83b725", "film_f0bc40dc033542afb1cc2413830b7958"] {
            let json = TestsHelper.readJsonFile(uid)
            Film.loadFromJson(jsonString: json)
            Favorite.toggleFavorite(film_uid: uid)
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetSectionsCount() {
        // Create new presenter
        let presenter = Presenter()
        
        // Check number of sections in Favorite mode
        presenter.favoriteMode = true
        XCTAssertEqual(presenter.getSectionsCount(), 1)
        
        // Check number of sections in Home mode
        presenter.favoriteMode = false
        XCTAssertEqual(presenter.getSectionsCount(), 2)
    }
    
    func testGetSectionTitle() {
        // Create new presenter
        let presenter = Presenter()
        
        // Check section titles in Favorite mode
        presenter.favoriteMode = true
        XCTAssertEqual(presenter.getSectionsCount(), 1)
        if presenter.getSectionsCount() == 1 {
            XCTAssertEqual(presenter.getSectionTitle(section: 0), "Favorites")
        }
        
        // Check section titles in Home mode
        presenter.favoriteMode = false
        XCTAssertEqual(presenter.getSectionsCount(), 2)
        if presenter.getSectionsCount() == 2 {
            XCTAssertEqual(presenter.getSectionTitle(section: 0), "Most Recent")
            XCTAssertEqual(presenter.getSectionTitle(section: 1), "Popular")
        }
    }
    
    func testGetRowsForSection() {
        // Create new presenter
        let presenter = Presenter()
        
        // Favorite Mode
        presenter.favoriteMode = true
        XCTAssertEqual(presenter.getRowsForSection(0), 3)
        
        // Home Mode
        presenter.favoriteMode = false
        XCTAssertEqual(presenter.getRowsForSection(0), 4)
        XCTAssertEqual(presenter.getRowsForSection(1), 16)
    }
    
    func testGetItyemForIndexPath() {
        // Create new presenter
        let presenter = Presenter()
        
        // Favorite Mode
        presenter.favoriteMode = true
        var item = presenter.getItyemForIndexPath(indexPath: NSIndexPath(row: 2, section: 0))
        XCTAssertEqual(item.title, "Little Red Riding Hood Up-to-date")
        XCTAssertEqual(item.synopsis, "")
        XCTAssertEqual(item.favorite, true)
        
        // Home Mode
        presenter.favoriteMode = false
        item = presenter.getItyemForIndexPath(indexPath: NSIndexPath(row: 0, section: 0))
        XCTAssertEqual(item.title, "Seeing the New Year In")
        XCTAssertEqual(item.synopsis, "")
        XCTAssertEqual(item.favorite, true)
    }
    
    func testToggleFavorite() {
        // Create new presenter
        let presenter = Presenter()
        presenter.favoriteMode = true
        
        // Before toggle
        presenter.favoriteMode = true
        XCTAssertEqual(presenter.getRowsForSection(0), 3)
        var item = presenter.getItyemForIndexPath(indexPath: NSIndexPath(row: 1, section: 0))
        XCTAssertEqual(item.title, "National Bicycle Week Begins  Daily Sketch Topical Budget 613-2")
        
        // Perform toggle
        presenter.toggleFavorite(indexPath: NSIndexPath(row: 1, section: 0))
        
        // After toggle
        presenter.favoriteMode = true
        XCTAssertEqual(presenter.getRowsForSection(0), 2)
        item = presenter.getItyemForIndexPath(indexPath: NSIndexPath(row: 1, section: 0))
        XCTAssertEqual(item.title, "Little Red Riding Hood Up-to-date")
    }
    
}
