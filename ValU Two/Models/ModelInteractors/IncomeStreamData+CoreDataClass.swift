//
//  IncomeStreamData+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 12/18/19.
//
//

import Foundation
import CoreData

@objc(IncomeStreamData)
public class IncomeStreamData: NSManagedObject {
    
    convenience init(incomeStream : IncomeStreamsJSON,  context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "IncomeStreamData", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.confidence = incomeStream.confidence
        self.monthlyIncome = incomeStream.monthlyIncome
        self.days = Double(incomeStream.days)
        self.name = incomeStream.name
        
        

        
        
    }

}
