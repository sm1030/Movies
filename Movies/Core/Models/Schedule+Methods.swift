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
    
    static func getInstance(uid: String, insertNewIfNeeded: Bool = false) -> Schedule? {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Schedule.self))
            fetchRequest.predicate = NSPredicate(format: "uid = %@", uid)
            if let fetchResults = try DataController.getContext().fetch(fetchRequest) as? [Schedule] {
                if fetchResults.count > 0 {
                    return fetchResults[0]
                } else if insertNewIfNeeded {
                    let schedule = NSEntityDescription.insertNewObject(forEntityName: String(describing: Schedule.self), into: DataController.getContext()) as? Schedule
                    schedule?.uid = uid
                    return schedule
                } else {
                    return nil
                }
            }
        } catch let error {
            print("ERROR: \(error)")
        }
        
        return nil
    }
    
    static func getAll() -> [Schedule]? {
        do {
            let fetchRequest: NSFetchRequest<Schedule> = Schedule.fetchRequest()
            return try DataController.getContext().fetch(fetchRequest)
        } catch let error {
            print("ERROR: \(error)")
        }
        return nil
    }
    
    static func deleteAll() {
        for schedule in Schedule.getAll() ?? [Schedule]() {
            DataController.getContext().delete(schedule)
        }
    }
    
    static func getAllDividers() -> [String] {
        var dividers = [String]()
        do {
            let fetchRequest: NSFetchRequest<Schedule> = Schedule.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "position", ascending: true)]
            let fetchResults = try DataController.getContext().fetch(fetchRequest)
            if fetchResults.count > 0 {
                for schedule in fetchResults {
                    if schedule.divider {
                        dividers.append(schedule.heading!)
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
            let fetchRequest: NSFetchRequest<Schedule> = Schedule.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "position", ascending: true)]
            let fetchResults = try DataController.getContext().fetch(fetchRequest)
            if fetchResults.count > 0 {
                var rightSection = false
                for schedule in fetchResults {
                    if schedule.divider {
                        let heading = schedule.heading
                        rightSection = heading == dividerName
                    } else {
                        if rightSection {
                            if schedule.film_uid != nil {
                                filmUids.append(schedule.film_uid!)
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
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? Dictionary<String, AnyObject>
            let objects = json?["objects"] as? Array<Dictionary<String, AnyObject>>
            if (objects?.count)! > 0 {
                if let collection = objects?[0] {
                    if let items = collection["items"] as? Array<Dictionary<String, AnyObject>> {
                        for item in items {
                            if let uid = item["uid"] as? String {
                                let schedule = Schedule.getInstance(uid: uid, insertNewIfNeeded: true)
                                schedule?.film_uid = Schedule.extractFilmUid(item["content_url"] as? String)
                                schedule?.divider = item["content_type"] as? String == "divider"
                                schedule?.position = (item["position"] as? Int16) ?? 0
                                schedule?.heading = item["heading"] as? String
                            }
                        }
                        DataController.saveContext()
                    }
                }
            }
            
        } catch let error {
            print("ERROR: \(error)")
        }
    }
    
    static func extractFilmUid(_ content_url: String?) -> String? {
        if let parts = content_url?.components(separatedBy: "/") {
            if parts.count == 5 {
                let part = parts[3]
                
                if part.range(of: "film_") != nil {
                    return part
                }
            }
        }
        
        return nil
    }
    
}
