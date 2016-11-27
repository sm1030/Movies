//
//  Film+CoreDataProperties.swift
//  Movies
//
//  Created by Alexandre Malkov on 27/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Film {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Film> {
        return NSFetchRequest<Film>(entityName: "Film");
    }

    @NSManaged public var image_url: String?
    @NSManaged public var synopsis: String?
    @NSManaged public var title: String?
    @NSManaged public var uid: String?

}
