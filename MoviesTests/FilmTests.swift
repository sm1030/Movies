//
//  FilmTests.swift
//  Movies
//
//  Created by Alexandre Malkov on 28/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import XCTest
@testable import Movies

class FilmTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Film.deleteAll()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddFilm() {
        // uid used in this test
        let uid1 = "film_a5e1022dfd874e169fd6da6597d0cd0f"
        let uid2 = "film_7a99b420e91e4513ac56cf12f3fb82f8"
        
        // Make sure that there is no record for uid1 and uid 2
        var film = Film.getInstance(uid: uid1)
        XCTAssertNil(film)
        film = Film.getInstance(uid: uid2)
        XCTAssertNil(film)
        
        // Load first uid
        var json = TestsHelper.readJsonFile(uid1)
        Film.loadFromJson(jsonString: json)
        film = Film.getInstance(uid: uid1)
        XCTAssertNotNil(film)
        XCTAssertEqual(film?.title, "Seeing the New Year In")
        XCTAssertEqual(film?.synopsis, "")
        
        // Load second uid
        json = TestsHelper.readJsonFile(uid2)
        Film.loadFromJson(jsonString: json)
        film = Film.getInstance(uid: uid2)
        XCTAssertNotNil(film)
        XCTAssertEqual(film?.title, "Christmas Celebrations and the Cruel Cat")
        XCTAssertEqual(film?.synopsis, "")
    }
    
}
