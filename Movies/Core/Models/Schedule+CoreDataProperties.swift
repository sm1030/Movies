//
//  Schedule+CoreDataProperties.swift
//  Movies
//
//  Created by Alexandre Malkov on 27/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Schedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule");
    }

    @NSManaged public var collection_uid: String?
    @NSManaged public var content_url: String?
    @NSManaged public var divider: Bool
    @NSManaged public var heading: String?
    @NSManaged public var position: Int16
    @NSManaged public var uid: String?

}
