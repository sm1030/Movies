//
//  Collection+CoreDataProperties.swift
//  Movies
//
//  Created by Alexandre Malkov on 27/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Collection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Collection> {
        return NSFetchRequest<Collection>(entityName: "Collection");
    }

    @NSManaged public var title: String?
    @NSManaged public var uid: String?

}
