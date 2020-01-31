//
//  Location+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 8/28/19.
//
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject{
    
    convenience init(location : LocationJSON, context: NSManagedObjectContext!){
        
        print(location)
        let entity = NSEntityDescription.entity(forEntityName: "Location", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.address = (location.address ?? nil)
        self.city = location.city ?? nil
        self.country = location.country ?? nil
        self.lat = location.lat ?? nil
        self.lon = location.lon ?? nil
        self.postalCode = location.postalCode ?? nil
        self.region = location.region ?? nil
        self.storeNumber = location.storeNumber ?? nil
        
        
    }

}
