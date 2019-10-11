//
//  Category+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 9/7/19.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject {
    
    convenience init(categoryEntry: CategoryEntry, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "Category", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.name = categoryEntry.name
        self.contains = categoryEntry.contains
        
        if let subCategories = categoryEntry.subCategories{
            self.subCategories = NSSet(array: subCategories)
        }
        
        
        
    }

}
