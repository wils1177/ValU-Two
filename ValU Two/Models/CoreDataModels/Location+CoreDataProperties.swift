//
//  Location+CoreDataProperties.swift
//  ValU Two
//
//  Created by Clayton Wilson on 9/5/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var postalCode: String?
    @NSManaged public var region: String?
    @NSManaged public var storeNumber: String?
    @NSManaged public var transaction: Transaction?

}

extension Location : Identifiable {

}
