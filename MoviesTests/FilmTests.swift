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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddFilm() {
        let uid = "film_a5e1022dfd874e169fd6da6597d0cd0f"
        var film = Film.getInstance(uid: uid)
        XCTAssertNil(film)
        let json = TestsHelper.readJsonFile(uid)
        Film.loadFromJson(jsonString: json)
        film = Film.getInstance(uid: uid)
        XCTAssertNotNil(film)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
