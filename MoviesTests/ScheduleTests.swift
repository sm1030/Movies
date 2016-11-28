//
//  ScheduleTests.swift
//  Movies
//
//  Created by Alexandre Malkov on 28/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import XCTest
@testable import Movies

class ScheduleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Schedule.deleteAll()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAddSchedule() {
        // Make sure Schedule table is empty
        XCTAssertEqual(Schedule.getAll()?.count, 0)
        
        // Add first item
        var schedule = Schedule.getInstance(uid: "1", insertNewIfNeeded: true)
        XCTAssertNotNil(schedule)
        XCTAssertEqual(schedule?.uid, "1")
        XCTAssertEqual(Schedule.getAll()?.count, 1)
        
        // Add second item
        schedule = Schedule.getInstance(uid: "2", insertNewIfNeeded: true)
        XCTAssertNotNil(schedule)
        XCTAssertEqual(schedule?.uid, "2")
        XCTAssertEqual(Schedule.getAll()?.count, 2)
        
        // Try to add the same item
        schedule = Schedule.getInstance(uid: "2", insertNewIfNeeded: true)
        XCTAssertNotNil(schedule)
        XCTAssertEqual(schedule?.uid, "2")
        XCTAssertEqual(Schedule.getAll()?.count, 2)
    }
    
    func testWithJson() {
        // Make sure Schedule table is empty
        XCTAssertEqual(Schedule.getAll()?.count, 0)
        
        // Load JSON file
        let fileName = "Home"
        let json = TestsHelper.readJsonFile(fileName)
        Schedule.loadFromJson(jsonString: json)
        
        // Check how many items we have now
        XCTAssertEqual(Schedule.getAll()?.count, 22)
        
        // Check first item
        var schedule = Schedule.getInstance(uid: "sche_7b4c7b54ecfb4748b7853aa5f87ac309")
        XCTAssertNotNil(schedule)
        XCTAssertEqual(schedule?.position, 10)
        XCTAssertEqual(schedule?.heading, "Most Recent")
        XCTAssertEqual(schedule?.divider, true)
        
        // Check second item
        schedule = Schedule.getInstance(uid: "sche_294646380be54a58832e7b86c03724bf")
        XCTAssertNotNil(schedule)
        XCTAssertEqual(schedule?.position, 20)
        XCTAssertEqual(schedule?.heading, nil)
        XCTAssertEqual(schedule?.divider, false)
    }
    
    func testGtAllDividers() {
        // Make sure Schedule table is empty
        XCTAssertEqual(Schedule.getAll()?.count, 0)
        
        // Load JSON file
        let fileName = "Home"
        let json = TestsHelper.readJsonFile(fileName)
        Schedule.loadFromJson(jsonString: json)
        
        // Get dividers
        let dividers = Schedule.getAllDividers()
        XCTAssertEqual(dividers.count, 2)
        
        // Inspect each header
        if dividers.count > 1 {
            XCTAssertEqual(dividers[0], "Most Recent")
            XCTAssertEqual(dividers[1], "Popular")
        }
    }
    
    func testGetFilmUids() {
        // Make sure Schedule table is empty
        XCTAssertEqual(Schedule.getAll()?.count, 0)
        
        // Load JSON file
        let fileName = "Home"
        let json = TestsHelper.readJsonFile(fileName)
        Schedule.loadFromJson(jsonString: json)
        
        // check "Most Recent" films
        var films = Schedule.getFilmUids(forDividerName: "Most Recent")
        XCTAssertEqual(films.count, 4)
        if films.count > 1 {
            XCTAssertEqual(films[0], "film_a5e1022dfd874e169fd6da6597d0cd0f")
            XCTAssertEqual(films[3], "film_5f4472c8afb645a7b94754dc0cb8812e")
        }
        
        // check "Popular" films
        films = Schedule.getFilmUids(forDividerName: "Popular")
        XCTAssertEqual(films.count, 16)
        if films.count > 1 {
            XCTAssertEqual(films[0], "film_62df77e60e2d44bdaf2dfaf970a5c32f")
            XCTAssertEqual(films[15], "film_de7d3af5e0134e7b86262f91afce3c05")
        }
    }
    
}
