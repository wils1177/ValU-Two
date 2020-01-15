//
//  Category+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 1/12/20.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var contains: [String]?
    @NSManaged public var name: String?
    @NSManaged public var icon: String?
    @NSManaged public var subCategories: NSSet?

}

// MARK: Generated accessors for subCategories
extension Category {

    @objc(addSubCategoriesObject:)
    @NSManaged public func addToSubCategories(_ value: Category)

    @objc(removeSubCategoriesObject:)
    @NSManaged public func removeFromSubCategories(_ value: Category)

    @objc(addSubCategories:)
    @NSManaged public func addToSubCategories(_ values: NSSet)

    @objc(removeSubCategories:)
    @NSManaged public func removeFromSubCategories(_ values: NSSet)

}
