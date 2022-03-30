//
//  FilterModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/27/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation


enum TimeFilters {
    case currentBudgetOnly
    case last30Days
    case last60Days
    case lastWeek
}

enum DirectionFilter {
    case income
    case expense
}


class TransactionFilterModel: ObservableObject {
    
    @Published var timeFilter : TimeFilters? = nil
    @Published var directionFilter : DirectionFilter?
    var unassignedFilter = false
    var unbudgetedFilter = false
    
    var predicateBuilder = PredicateBuilder()
    
    func areThereAnyFilterEnabled() -> Bool{
        if timeFilter == nil && directionFilter == nil{
            return false
        }
        else{
            return true
        }
    }
    
    
    func getPredicateBasedOnState() -> NSCompoundPredicate {
        
        let timePredicate = getTimePredicate()
        
        let directionPredicate = getDirectionPredicate()
        
        if directionPredicate != nil{
            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, directionPredicate!])
            return compound
        }
        else{
            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate])
            return compound
        }
        
    }
    
    func getTimePredicate() -> NSPredicate {
        
        if self.timeFilter == TimeFilters.last30Days{
            return predicateBuilder.generateLastMonthPredicate()
        }
        else if self.timeFilter == TimeFilters.lastWeek{
            return predicateBuilder.generateLastWeekPredicate()
        }
        else {
            return predicateBuilder.generateLast60daysPredicate()
        }
        
    }
    
    func getDirectionPredicate() -> NSPredicate? {
        if directionFilter == DirectionFilter.expense{
            return self.predicateBuilder.generateIncomeAmountPredicate()
        }
        else if directionFilter == DirectionFilter.income{
            return self.predicateBuilder.generateExpenseAmountPredicate()
        }
        else {
            return nil
        }
    }
    
    func changeTimeFilterTo(time: TimeFilters?){
        self.timeFilter = time
    }
    
    func changeDirectionFilterTo(filter: DirectionFilter?){
        self.directionFilter = filter
    }
    
    
}
