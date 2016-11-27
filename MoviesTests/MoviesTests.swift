//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Alexandre Malkov on 27/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let parser = ResponseParser()
        let json = readFile("film_a5e1022dfd874e169fd6da6597d0cd0f")
        parser.parseFilmResponse(jsonString: json)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func readFile(_ fileName: String) -> String {
        var text = ""
        
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                text = try String(contentsOfFile: filePath)
            } catch let error {
                print("ERROR: \(error)")
            }
        }
        
        return text
    }
    
}
