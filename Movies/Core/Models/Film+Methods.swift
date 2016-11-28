//
//  Film+Methods.swift
//  Movies
//
//  Created by Alexandre Malkov on 27/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import CoreData

extension Film {

    static func getInstance(uid: String, insertNewIfNeeded: Bool = false) -> Film? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Film.self))
            fetchRequest.predicate = NSPredicate(format: "uid = %@", uid)
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [Film] {
                if fetchResults.count > 0 {
                    return fetchResults[0]
                } else if insertNewIfNeeded {
                    return NSEntityDescription.insertNewObject(forEntityName: String(describing: Film.self), into: DataController.getContext()) as? Film
                } else {
                    return nil
                }
            }
        } catch let error {
            print("ERROR: \(error)")
        }
        
        return nil
    }
    
    static func deleteAll() {
        do {
            let fetchRequest: NSFetchRequest<Film> = Film.fetchRequest()
            let fetchResults = try DataController.getContext().fetch(fetchRequest)

            if fetchResults.count > 0 {
                for film in fetchResults {
                    DataController.getContext().delete(film)
                }
            }
            
            DataController.saveContext()
        } catch let error {
            print("ERROR: \(error)")
        }
    }
    
    static func loadFromJson(jsonString: String) {
        let data = jsonString.data(using: .utf8)
        var json: Dictionary<String, AnyObject>
        do {
            json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as! Dictionary<String, AnyObject>
            let uid: String = json["uid"] as! String
            
            if let film = Film.getInstance(uid: uid, insertNewIfNeeded: true) {
                film.uid = uid
                film.title = json["title"] as? String
                film.synopsis = json["synopsis"] as? String
                DataController.saveContext()
            }
            
        } catch let error {
            print("ERROR: \(error)")
        }
    }
    
}
