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
    
    static func getInstance(film_uid: String, insertNewIfNeeded: Bool = false) -> Favorite? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Favorite.self))
            fetchRequest.predicate = NSPredicate(format: "film_uid = %@", film_uid)
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [Favorite] {
                if fetchResults.count > 0 {
                    return fetchResults[0]
                } else if insertNewIfNeeded {
                    let favorite = NSEntityDescription.insertNewObject(forEntityName: String(describing: Favorite.self), into: DataController.getContext()) as? Favorite
                    favorite?.film_uid = film_uid
                    return favorite
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
        for favorite in Favorite.getAll() ?? [Favorite]() {
            DataController.getContext().delete(favorite)
        }
    }
    
    static func toggleFavorite(film_uid: String) {
        if getInstance(film_uid: film_uid) != nil {
            Favorite.deleteInstance(film_uid: film_uid)
        } else {
            _ = Favorite.getInstance(film_uid: film_uid, insertNewIfNeeded: true)
        }
        DataController.saveContext()
    }
    
    static func isFavorite(film_uid: String) -> Bool {
        return getInstance(film_uid: film_uid) != nil
    }
    
    static func deleteInstance(film_uid: String) {
        if let favorite = getInstance(film_uid: film_uid) {
            DataController.getContext().delete(favorite)
        }
    }
    
    static func getAll() -> [Favorite]? {
        do {
            let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
            return try DataController.getContext().fetch(fetchRequest)
        } catch let error {
            print("ERROR: \(error)")
        }
        return nil
    }
    
}
