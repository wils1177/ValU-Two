//
//  TransactionDateCache+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 4/4/20.
//
//

import Foundation
import CoreData

@objc(TransactionDateCache)
public class TransactionDateCache: NSManagedObject {
    
    convenience init(dateFrom : Date, timeFrame: Int32, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "TransactionDateCache", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.income = 0.0
        self.expenses = 0.0
        
        self.id = UUID()
        
        self.timeFrame = timeFrame
        setDates(dateFrom: dateFrom)
        
    }
    
    convenience init(startDate : Date, endDate: Date, timeFrame: Int32, context: NSManagedObjectContext!){
        
        let entity = NSEntityDescription.entity(forEntityName: "TransactionDateCache", in: context)
        self.init(entity: entity!, insertInto: context)
        
        self.income = 0.0
        self.expenses = 0.0
        
        self.id = UUID()
        
        self.timeFrame = timeFrame
        self.startDate = startDate
        self.endDate = endDate
        
    }
    
    func setDates(dateFrom: Date){
        if self.timeFrame == TimeFrame.weekly.rawValue{
            self.startDate = dateFrom.startOfWeek!
            self.endDate = dateFrom.endOfWeek!
        }
        else{
            self.startDate = dateFrom.startOfMonth!
            self.endDate = dateFrom.endOfMonth!
        }
        
    }
    

}
