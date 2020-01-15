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
        self.icon = categoryEntry.icon
        
        if let subCategories = categoryEntry.subCategories{
            
            var subCategoryList = [Category]()
            
            for subCategory in subCategories{
                let newCategory = Category(categoryEntry: subCategory, context: context)
                subCategoryList.append(newCategory)
            }
            
            self.subCategories = NSSet(array: subCategoryList)
        }
        
        
        
    }

}
