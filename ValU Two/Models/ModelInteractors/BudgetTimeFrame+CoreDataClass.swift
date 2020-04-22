//
//  BudgetTimeFrame+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 4/12/20.
//
//

import Foundation
import CoreData

@objc(BudgetTimeFrame)
public class BudgetTimeFrame: NSManagedObject {
    
    convenience init(context: NSManagedObjectContext, timeframe: Int32, startDate: Date, endDate: Date){
        
        let entity = NSEntityDescription.entity(forEntityName: "BudgetTimeFrame", in: context)
        self.init(entity: entity!, insertInto: context)

        
        self.timeFrame = timeframe
        self.startDate = startDate
        self.endDate = endDate
        
    }

}
