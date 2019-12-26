//
//  IncomeData+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 12/18/19.
//
//

import Foundation
import CoreData

@objc(IncomeData)
public class IncomeData: NSManagedObject {
    
    convenience init(income : IncomeJSON, incomeStreams : [IncomeStreamsJSON], context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "IncomeData", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.lastYearBeforeIncomeTax = income.lastYearIncomeBeforeTax
        self.lastYearIncome = income.lastYearIncome
        self.projectedYearlyIncome = income.projectedIncome
        self.projectedYearlyIncomeBeforeTax = income.projectedIncomeBeforeTax
        
        for stream in incomeStreams{
            
            let newStream = IncomeStreamData(incomeStream: stream, context: context)
            self.addToIncomeStreams(newStream)
        }

        
        
    }

}
