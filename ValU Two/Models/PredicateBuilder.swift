//
//  PredicateBuilder.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import CoreData

class PredicateBuilder{
    

    
    func generateInBudgetPredicate(startDate: Date, endDate: Date) -> NSPredicate{
        
        return NSPredicate(format: "(date > %@) AND (date <= %@)", startDate as NSDate, endDate as NSDate)
        
    }
    
    
    func generateCategoryPredicate(categoryName: String) -> NSPredicate{
        return NSPredicate(format: "(name == %@)", categoryName as String)
    }
    
}
