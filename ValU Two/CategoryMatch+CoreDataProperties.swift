//
//  CategoryMatch+CoreDataProperties.swift
//  
//
//  Created by Clayton Wilson on 5/11/20.
//
//

import Foundation
import CoreData


extension CategoryMatch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryMatch> {
        return NSFetchRequest<CategoryMatch>(entityName: "CategoryMatch")
    }

    @NSManaged public var amount: Float
    @NSManaged public var id: UUID?
    @NSManaged public var itemId: String?
    @NSManaged public var spendingCategory: SpendingCategory?
    @NSManaged public var transaction: Transaction?

}
