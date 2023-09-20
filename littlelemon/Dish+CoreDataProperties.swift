//
//  Dish+CoreDataProperties.swift
//  littlelemon
//
//  Created by Mark Chen on 9/20/23.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var price: String?

}

extension Dish : Identifiable {

}
