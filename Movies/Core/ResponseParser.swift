//
//  ResponseParser.swift
//  Movies
//
//  Created by Alexandre Malkov on 27/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import CoreData

class ResponseParser {
    
    func parseHomeResponse(jsonString: String) {
        
    }
    
    func parseFilmResponse(jsonString: String) {
        let data = jsonString.data(using: .utf8)
        var json: Dictionary<String, AnyObject>
        do {
            json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as! Dictionary<String, AnyObject>
            
            let uid: String = json["uid"] as! String
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Film.self))
            fetchRequest.predicate = NSPredicate(format: "uid = %@", uid)
            
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [NSManagedObject] {
                let film: Film
                
                if fetchResults.count > 0 {
                    film = fetchResults[0] as! Film
                } else {
                    let mo = NSEntityDescription.insertNewObject(forEntityName: String(describing: Film.self), into: DataController.getContext())
                    film = mo as! Film
                }
                
                film.uid = uid
                
            }
            
        } catch let error {
            print("ERROR: \(error)")
        }
    }
    
}
