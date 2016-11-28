//
//  TestsHelper.swift
//  Movies
//
//  Created by Alexandre Malkov on 28/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation

class TestsHelper {
    
    class func readJsonFile(_ fileName: String) -> String {
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
