//
//  Schedule+Methods.swift
//  Movies
//
//  Created by Alexandre Malkov on 27/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import CoreData

extension Schedule {
    
    static func getInstance(uid: String) -> Schedule? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Schedule.self))
            fetchRequest.predicate = NSPredicate(format: "uid = %@", uid)
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [Schedule] {
                let schedule: Schedule
                
                if fetchResults.count > 0 {
                    schedule = fetchResults[0]
                } else {
                    schedule = NSEntityDescription.insertNewObject(forEntityName: String(describing: Schedule.self), into: DataController.getContext()) as! Schedule
                }
                return schedule
            }
        } catch let error {
            print("ERROR: \(error)")
        }
        
        return nil
    }
    
    static func deleteAll() {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Schedule.self))
            fetchRequest.predicate = NSPredicate()
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [Schedule] {
                if fetchResults.count > 0 {
                    for schedule in fetchResults {
                        DataController.getContext().delete(schedule)
                    }
                }
            }
        } catch let error {
            print("ERROR: \(error)")
        }
    }
    
    static func getAllDividers() -> [String] {
        var dividers = [String]()
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Schedule.self))
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "position", ascending: true)]
            fetchRequest.predicate = NSPredicate()
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [Schedule] {
                if fetchResults.count > 0 {
                    for schedule in fetchResults {
                        if schedule.divider {
                            dividers.append(schedule.heading!)
                        }
                    }
                }
            }
        } catch let error {
            print("ERROR: \(error)")
        }
        
        return dividers
    }
    
    static func getFilmUids(forDividerName dividerName: String) -> [String] {
        var filmUids = [String]()
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Schedule.self))
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "position", ascending: true)]
            fetchRequest.predicate = NSPredicate()
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [Schedule] {
                if fetchResults.count > 0 {
                    var rightSection = false
                    for schedule in fetchResults {
                        if schedule.divider {
                            let heading = schedule.heading
                            rightSection = heading == dividerName
                        } else {
                            if rightSection {
                                filmUids.append(schedule.content_url!)
                            }
                        }
                    }
                }
            }
        } catch let error {
            print("ERROR: \(error)")
        }
        
        return filmUids
    }
    
    static func loadFromJson(jsonString: String) {
        let data = jsonString.data(using: .utf8)
        var json: Dictionary<String, AnyObject>
        do {
            json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as! Dictionary<String, AnyObject>
            let uid: String = json["uid"] as! String
            
            if let film = Film.getInstance(uid: uid) {
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
