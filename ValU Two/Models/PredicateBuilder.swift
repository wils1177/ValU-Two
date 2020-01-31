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
    
    func generateThisWeekPredicate() -> NSPredicate{
        
        var dateComponents = DateComponents()
        dateComponents.setValue(-1, for: .day); // +1 day
        let now = Date() // Current date
        let yesterday = Calendar.current.date(byAdding: dateComponents, to: now)
        
        
        dateComponents.setValue(-7, for: .day); // +1 day
        let lastWeek = Calendar.current.date(byAdding: dateComponents, to: now)
        
        return NSPredicate(format: "(date >= %@) AND (date < %@)", lastWeek! as NSDate, yesterday! as NSDate)
        
            
    }
    
    func generateTodayPredicate() -> NSPredicate{
        
        var comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        comp.timeZone = TimeZone(abbreviation: "UTC")!
        let truncated = Calendar.current.date(from: comp)!
        
        return NSPredicate(format: "(date >= %@)", truncated as NSDate)
        
    
    }
    
    func generateEarlierThisMonthPredicate() -> NSPredicate{
        
        var dateComponents = DateComponents()
        dateComponents.setValue(-7, for: .day); // +1 day
        let now = Date() // Current date
        let lastWeek = Calendar.current.date(byAdding: dateComponents, to: now)
        
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
        let startOfMonth = Calendar.current.date(from: comp)
        
        return NSPredicate(format: "(date >= %@) AND (date < %@)", startOfMonth! as NSDate, lastWeek! as NSDate)
        
    }
    
    
    func generateCategoryPredicate(categoryName: String) -> NSPredicate{
        return NSPredicate(format: "(name == %@)", categoryName as String)
    }
    
}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
}
