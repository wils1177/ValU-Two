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
    

    
    func generateInDatesPredicate(startDate: Date, endDate: Date) -> NSPredicate{
        
        return NSPredicate(format: "(date >= %@) AND (date <= %@)", startDate as NSDate, endDate as NSDate)
        
    }
    
    func generateInBetweenDatesPredicate(executionDate: Date) -> NSPredicate{

        return NSPredicate(format: "(endDate >= %@) AND (startDate <= %@)", executionDate as NSDate, executionDate as NSDate)
    }

    
    //TODO: Finish this function so that it actually returns something. It will fail right now
    func generateOtherCategoryInBudgetPredicate(startDate: Date, endDate: Date) -> NSPredicate{
        return NSPredicate(format: "(date > %@) AND (date <= %@) AND ", startDate as NSDate, endDate as NSDate)
    }
    

    
    func generateTimeFramePredicate(timeFrame: Int32) -> NSPredicate{
        return NSPredicate(format: "(timeFrame == %@)", timeFrame as NSNumber)
   }
    
    func generateNegativeAmountPredicate(startDate: Date, endDate: Date) -> NSPredicate{
        let zero = 0.0
        return NSPredicate(format: "(amount <= %@) AND (date >= %@) AND (date <= %@)", zero as NSNumber, startDate as NSDate, endDate as NSDate)
    }
    
    func generateExpenseAmountPredicate() -> NSPredicate{
        let zero = 0.0
        return NSPredicate(format: "amount <= %@", zero as NSNumber)
    }
    
    func generateIncomeAmountPredicate() -> NSPredicate{
        let zero = 0.0
        return NSPredicate(format: "amount > %@", zero as NSNumber)
    }
    
    func generateUnassignedPredicate() -> NSPredicate {
        return NSPredicate(format: "categoryMatches.@count>%d", 0 as NSNumber)
    }
    

    
    
    
    
    
    
    func generateLastWeekPredicate() -> NSPredicate{
        
        var dateComponents = DateComponents()
        dateComponents.setValue(0, for: .day); // +1 day
        let now = Date() // Current date
        let yesterday = Calendar.current.date(byAdding: dateComponents, to: now)
        
        
        dateComponents.setValue(-7, for: .day); // +1 day
        let lastWeek = Calendar.current.date(byAdding: dateComponents, to: now)
        return NSPredicate(format: "(date >= %@) AND (date < %@)", lastWeek! as NSDate, yesterday! as NSDate)
        
            
    }
    
    func generateLastMonthPredicate() -> NSPredicate{
        
        var dateComponents = DateComponents()
        dateComponents.setValue(0, for: .day); // +1 day
        let now = Date() // Current date
        let yesterday = Calendar.current.date(byAdding: dateComponents, to: now)
        
        
        dateComponents.setValue(-30, for: .day); // +1 day
        let lastWeek = Calendar.current.date(byAdding: dateComponents, to: now)
        return NSPredicate(format: "(date >= %@) AND (date < %@)", lastWeek! as NSDate, yesterday! as NSDate)
        
            
    }
    
    func generatePreviousMonthPredicate() -> NSPredicate{
        let today = Date()
        
        
        let start = Calendar.current.date(byAdding: .month, value: -2, to: today)!
        let end = Calendar.current.date(byAdding: .month, value: -1, to: today)!
        
        return NSPredicate(format: "(date >= %@) AND (date < %@)", start as NSDate, end as NSDate)
        
    }
    
    func generatePreviousWeekPredicate() -> NSPredicate{
        let today = Date()
        
        
        let start = Calendar.current.date(byAdding: .weekOfMonth, value: -2, to: today)!
        let end = Calendar.current.date(byAdding: .weekOfMonth, value: -1, to: today)!
        
        return NSPredicate(format: "(date >= %@) AND (date < %@)", start as NSDate, end as NSDate)
        
    }
    
    func generateLast60daysPredicate() -> NSPredicate{
        
        var dateComponents = DateComponents()
        dateComponents.setValue(0, for: .day); // +1 day
        let now = Date() // Current date
        let yesterday = Calendar.current.date(byAdding: dateComponents, to: now)
        
        
        dateComponents.setValue(-60, for: .day); // +1 day
        let lastWeek = Calendar.current.date(byAdding: dateComponents, to: now)
        return NSPredicate(format: "(date >= %@) AND (date < %@)", lastWeek! as NSDate, yesterday! as NSDate)
        
            
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
        
        dateComponents.setValue(-30, for: .day); // +1 day
        let monthAgo = Calendar.current.date(byAdding: dateComponents, to: now)
        
        return NSPredicate(format: "(date >= %@) AND (date < %@)", monthAgo! as NSDate, lastWeek! as NSDate)
        
    }
    
    
    func generateCategoryPredicate(categoryName: String) -> NSPredicate{
        return NSPredicate(format: "(name == %@)", categoryName as String)
    }
    
    func generateItemPredicate(itemId: String) -> NSPredicate{
        return NSPredicate(format: "(itemId == %@)", itemId as String)
    }
    
    func generateTransactionIdPredicate(transactionId: String) -> NSPredicate{
        return NSPredicate(format: "(transactionId == %@)", transactionId as String)
    }
    
    func generatePastBudgetPredicate(currentDate: Date) -> NSPredicate{
        
        return NSPredicate(format: "active == false AND (endDate <= %@)", currentDate as NSDate)
    }
    
    func generateFutureBudgetPredicate(currentDate: Date) -> NSPredicate{
        
        return NSPredicate(format: "startDate > %@", currentDate as NSDate)
    }
    
    func generateCurrentBudgetPredicate(currentDate: Date) -> NSPredicate{
        return NSPredicate(format: "(startDate <= %@) AND (endDate >= %@)", currentDate as NSDate, currentDate as NSDate)
    }
    
    func generateIncompleteBudgetPredicate() -> NSPredicate{
        return NSPredicate(format: "onboardingComplete == false")
    }
    
    func generateByIdPredicate(id: UUID) -> NSPredicate{
        return NSPredicate(format: "id == %@", id as CVarArg)
    }
    
    func generateByAccountIdPredicate(id: String) -> NSPredicate{
        return NSPredicate(format: "accountId == %@", id as String)
    }
    
    func generateTransactionsForCategoryIdPredicate(ids: [UUID]) -> NSPredicate{
        return NSPredicate(format: "ANY categoryMatches.spendingCategory.id IN %@", ids)
    }
    
    func generateRuleByNamePredicate(name: String) -> NSPredicate{
        return NSPredicate(format: "name == %@", name as String)
    }
    
    func generateAccoutnIdAndDatePredicate(accountId: String, date: Date) -> NSPredicate{
        return NSPredicate(format: "(date == %@) AND (accountId == %@)", date as NSDate, accountId as String)
    }
    

    
}


