//
//  Favorite+CoreDataProperties.swift
//  Movies
//
//  Created by Alexandre Malkov on 27/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite");
    }

    @NSManaged public var film_uid: String?
    @NSManaged public var value: Bool

}
