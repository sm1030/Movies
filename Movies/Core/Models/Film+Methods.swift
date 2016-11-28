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
                    let film = NSEntityDescription.insertNewObject(forEntityName: String(describing: Film.self), into: DataController.getContext()) as? Film
                    film?.uid = uid
                    return film
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
        for film in Film.getAll() ?? [Film]() {
            DataController.getContext().delete(film)
        }
    }
    
    static func getAll() -> [Film]? {
        do {
            let fetchRequest: NSFetchRequest<Film> = Film.fetchRequest()
            return try DataController.getContext().fetch(fetchRequest)
        } catch let error {
            print("ERROR: \(error)")
        }
        return nil
    }
    
    static func loadFromJson(jsonString: String) {
        let data = jsonString.data(using: .utf8)
        var json: Dictionary<String, AnyObject>
        do {
            json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as! Dictionary<String, AnyObject>
            let uid: String = json["uid"] as! String
            
            if let film = Film.getInstance(uid: uid, insertNewIfNeeded: true) {
                film.title = json["title"] as? String
                film.synopsis = json["synopsis"] as? String
                DataController.saveContext()
            }
            
        } catch let error {
            print("ERROR: \(error)")
        }
    }
    
}
