//
//  ItemData+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 8/28/19.
//
//

import Foundation
import CoreData

@objc(ItemData)
public class ItemData: NSManagedObject {
    
    convenience init(item: ItemJSON, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "ItemData", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.error = item.error
        self.institutionId = item.institutionId
        self.itemId = item.institutionId
        
    }
    
    

}
