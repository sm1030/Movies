//
//  FavoriteTests.swift
//  Movies
//
//  Created by Alexandre Malkov on 28/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import XCTest
@testable import Movies

class FavoriteTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Favorite.deleteAll()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddFavorite() {
        // uid used in this test
        let uid1 = "film_a5e1022dfd874e169fd6da6597d0cd0f"
        let uid2 = "film_7a99b420e91e4513ac56cf12f3fb82f8"
        
        // Make sure there is no records
        XCTAssertEqual(Favorite.getAll()?.count, 0)
        
        // Load first uid
        var favorite = Favorite.getInstance(uid: uid1, insertNewIfNeeded: true)
        XCTAssertNotNil(favorite)
        XCTAssertEqual(favorite?.film_uid, uid1)
        XCTAssertEqual(favorite?.value, false)
        
        // Update first uid
        favorite?.value = true
        
        // Load second uid
        favorite = Favorite.getInstance(uid: uid2, insertNewIfNeeded: true)
        XCTAssertNotNil(favorite)
        XCTAssertEqual(favorite?.film_uid, uid2)
        XCTAssertEqual(favorite?.value, false)
        
        // Check first item value
        favorite = Favorite.getInstance(uid: uid1)
        XCTAssertNotNil(favorite)
        XCTAssertEqual(favorite?.value, true)
    }
    
}
