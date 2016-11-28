//
//  Favorite+Methods.swift
//  Movies
//
//  Created by Alexandre Malkov on 27/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import CoreData

extension Favorite {
    
    static func getInstance(uid: String) -> Favorite? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Favorite.self))
            fetchRequest.predicate = NSPredicate(format: "uid = %@", uid)
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [Favorite] {
                let favorite: Favorite
                
                if fetchResults.count > 0 {
                    favorite = fetchResults[0]
                } else {
                    favorite = NSEntityDescription.insertNewObject(forEntityName: String(describing: Favorite.self), into: DataController.getContext()) as! Favorite
                }
                return favorite
            }
        } catch let error {
            print("ERROR: \(error)")
        }
    
        return nil
    }
    
    static func deleteAll() {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Favorite.self))
            fetchRequest.predicate = NSPredicate()
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [Favorite] {
                if fetchResults.count > 0 {
                    for favorite in fetchResults {
                        DataController.getContext().delete(favorite)
                    }
                }
            }
        } catch let error {
            print("ERROR: \(error)")
        }
    }
    
}
