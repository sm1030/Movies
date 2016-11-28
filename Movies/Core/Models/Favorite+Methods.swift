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
    
    static func getInstance(uid: String, insertNewIfNeeded: Bool = false) -> Favorite? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Favorite.self))
            fetchRequest.predicate = NSPredicate(format: "film_uid = %@", uid)
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [Favorite] {
                if fetchResults.count > 0 {
                    return fetchResults[0]
                } else if insertNewIfNeeded {
                    return NSEntityDescription.insertNewObject(forEntityName: String(describing: Favorite.self), into: DataController.getContext()) as? Favorite
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
