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
    case previousWeek
    case previous30Days
    case custom
}

struct TimeFilter{
    
    let type : TimeFilters
    let startDate : Date?
    let endDate: Date?
    
}

enum DirectionFilter {
    case income
    case expense
}


class TransactionFilterModel: CategoryListViewModel, ObservableObject {
    
    
    
    @Published var timeFilter : TimeFilter? = nil
    @Published var directionFilter : DirectionFilter?
    var unassignedFilter = false
    var unbudgetedFilter = false
    
    var predicateBuilder = PredicateBuilder()
    
    var spendingCategories = SpendingCategoryService().getSubSpendingCategories()
    
    @Published var selectedCategoryNames = [String]()
    
    @Published var categoryFilters = [SpendingCategory]()
    
    func areThereAnyFilterEnabled() -> Bool{
        if timeFilter == nil && directionFilter == nil && categoryFilters.count == 0{
            return false
        }
        else{
            return true
        }
    }
    
    
    func getPredicateBasedOnState() -> NSCompoundPredicate {
        
        let timePredicate = getTimePredicate()
        
        let directionPredicate = getDirectionPredicate()
        
        let categoryPredicate = getCategoryPredicate()
        
        if directionPredicate != nil && categoryPredicate == nil{
            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, directionPredicate!])
            return compound
        }
        else if categoryPredicate != nil && directionPredicate == nil{
            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, categoryPredicate!])
            return compound
        }
        else if categoryPredicate != nil && directionPredicate != nil{
            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, categoryPredicate!, directionPredicate!])
            return compound
        }
        else{
            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate])
            return compound
        }
        
    }
    
    func getTimePredicate() -> NSPredicate {
        
        if self.timeFilter?.type == TimeFilters.last30Days{
            return predicateBuilder.generateLastMonthPredicate()
        }
        else if self.timeFilter?.type == TimeFilters.lastWeek{
            return predicateBuilder.generateLastWeekPredicate()
        }
        else if self.timeFilter?.type == TimeFilters.custom{
            return predicateBuilder.generateInDatesPredicate(startDate: self.timeFilter!.startDate!, endDate: self.timeFilter!.endDate!)
        }
        else if self.timeFilter?.type == TimeFilters.previousWeek{
            return predicateBuilder.generatePreviousWeekPredicate()
        }
        else if self.timeFilter?.type == TimeFilters.previous30Days{
            return predicateBuilder.generatePreviousMonthPredicate()
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
    
    func getCategoryPredicate() -> NSPredicate? {
        
        if categoryFilters.count == 0 {
            return nil
        }
        
        var ids = [UUID]()
        for category in categoryFilters{
            ids.append(category.id!)
        }
        return predicateBuilder.generateTransactionsForCategoryIdPredicate(ids: ids)
    }
    
    func changeTimeFilterTo(time: TimeFilters?, start: Date?, end: Date?){
        if time != nil{
            let filter = TimeFilter(type: time!, startDate: start, endDate: end)
            self.timeFilter = filter
        }
        else{
            self.timeFilter = nil
        }
        
    }
    
    func changeDirectionFilterTo(filter: DirectionFilter?){
        self.directionFilter = filter
    }
    
    func changeCategoryFilter(){
        self.categoryFilters = [SpendingCategory]()
        for category in self.spendingCategories{
            for name in selectedCategoryNames{
                if category.name == name{
                    self.categoryFilters.append(category)
                }
            }
        }
        self.selectedCategoryNames = [String]()
    }
    
    func clearCategoryFilter(){
        self.categoryFilters = [SpendingCategory]()
        self.selectedCategoryNames = [String]()
    }
    
    func filtersSubmitted(time: TimeFilters?, start: Date?, end: Date?, direction: DirectionFilter?){
        
        changeTimeFilterTo(time: time, start: start, end: end)
        
        changeDirectionFilterTo(filter: direction)
        
        changeCategoryFilter()
    }
    
    func selectedCategoryName(name: String) {
        self.selectedCategoryNames.append(name)
    }
    
    func deSelectedCategoryName(name: String) {
        self.selectedCategoryNames.removeAll { $0 == name}
    }
    
    func isSelected(name: String) -> Bool {
        for category in self.selectedCategoryNames{
            if name == category{
                return true
            }
        }
        return false
    }
    
    func submit() {
        
    }
    
    func hide(category: SpendingCategory) {
        
    }
    
}
