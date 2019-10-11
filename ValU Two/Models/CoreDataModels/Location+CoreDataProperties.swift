//
//  Location+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 9/2/19.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var lat: String?
    @NSManaged public var lon: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var region: String?
    @NSManaged public var storeNumber: String?
    @NSManaged public var address: String?

}
