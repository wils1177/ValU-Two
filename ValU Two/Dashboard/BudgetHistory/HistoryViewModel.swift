//
//  HistoryViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

enum HistoryGraphViewState{
    case All
    case Other
    case Section
}

struct BudgetSectionTotals{
    var section: BudgetSection
    var total: Double
}

class HistoryEntryViewData: Hashable{
    var title = "test"
    var spent : String
    var remaining: String
    var percentage: CGFloat
    var spendingCardViewData: SpendingCardViewData
    var id = UUID()
    
    init(title : String, spent: String, remaining: String, percentage: CGFloat, spendingCardViewData: SpendingCardViewData){
        self.title = title
        self.spent = spent
        self.remaining = remaining
        self.percentage = percentage
        self.spendingCardViewData = spendingCardViewData
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: HistoryEntryViewData, rhs: HistoryEntryViewData) -> Bool {
        return lhs.id == rhs.id
    }
    
}

class HistoryViewModel : ObservableObject {
    
    @Published var historicalBudgets : [Budget]
    var coordinator : HistoryTabCoordiantor?
    var viewData = [HistoryEntryViewData]()
    
    var service : BudgetStatsService
    
    var activeBudget: Budget?

    init(budget: Budget? = nil){
        
        let pastQuery = PredicateBuilder().generatePastBudgetPredicate(currentDate: Date())
        
        let budgets = try! DataManager().getBudgets(predicate: pastQuery)
        self.historicalBudgets = budgets
        self.service = BudgetStatsService(budgets: budgets)
        self.activeBudget = budget
        generateViewData()
    }
    
    
    
    
    func testBudgetCopy(){
        
        if activeBudget != nil {
            let copier = BudgetCopyer()
            let oldBudget = self.activeBudget!
            
            let newBudget = copier.copyBudgetForNextPeriod(budget: self.activeBudget!)
            self.historicalBudgets.append(oldBudget)
            oldBudget.startDate = Calendar.current.date(byAdding: .day, value: -60, to: oldBudget.startDate!)
            oldBudget.endDate = Calendar.current.date(byAdding: .day, value: -60, to: oldBudget.endDate!)
            DataManager().saveDatabase()
        }
        else{
            print("no active budget available!")
        }
        
 
    }
    
    func createCashFlowData() -> [HistoryGraphBar]{
        var data = [HistoryGraphBar]()
        
        let periods = 5
        
        
        var endDate = Date().endOfMonth!
        
        var startDate = Date().startOfMonth!
        
        
        
        for _ in 1...periods{

            let name = CommonUtils.getDateTitleShort(date: startDate)
            
            
            let transactions = TransactionsCategoryFetcher.getTransactionsForDateRange(startDate: startDate, endDate: endDate)
            
            
            var spentTotal = 0.0
            var earnedTotal = 0.0
            
            for transaction in transactions {
                if transaction.isHidden{
                    continue
                }
                else{
                    if transaction.amount > 0.0{
                        spentTotal = spentTotal + transaction.amount
                    }
                    else{
                        earnedTotal = earnedTotal + (transaction.amount * -1)
                    }
                }
            }
            
            var graphSegements = [HistoryGraphBarSegment]()
            let income = HistoryGraphBarSegment(color: Color(.systemGreen), name: "Income", value: earnedTotal, icon: "arrow.up")
            
            graphSegements.append(income)
            
            let outcome = HistoryGraphBarSegment(color: Color(.systemRed), name: "Spending", value: spentTotal, icon: "arrow.down")
            
            graphSegements.append(outcome)
            
            let total = earnedTotal - spentTotal
                
            data.append(HistoryGraphBar(label: name, totalValue: total, segments: graphSegements))
            
           endDate = Calendar.current.date(byAdding: .month, value: -1, to: endDate)!
           startDate = Calendar.current.date(byAdding: .month, value: -1, to: startDate)!
  
            }
        
        return data
        
    }
    
    
    
    func createSpendingGraphData(state: HistoryGraphViewState, budgetSection: BudgetSection?) -> [HistoryGraphBar]{
        
        var sectionsToUse = [BudgetSection]()
        
        let budget = self.activeBudget
        
        if budget != nil{
            
            if state == .All{
                sectionsToUse = budget!.getBudgetSections()
                
            }
            else if state == .Other{
                sectionsToUse = [BudgetSection]()
            }
            else if state == .Section {
                sectionsToUse.append(budgetSection!)
            }
            
        }
        
        return createGraphDataForSection(sectionsToUse: sectionsToUse, state: state)
    }
    
    func createGraphDataForSection(sectionsToUse: [BudgetSection], state: HistoryGraphViewState) -> [HistoryGraphBar]{
        
        let periods = 5
        
        
        var endDate = Date().endOfMonth!
        
        var startDate = Date().startOfMonth!
        
        var bars = [HistoryGraphBar]()
        
        
        
        
        for _ in 1...periods{
            
            var sectionTotals = [BudgetSectionTotals]()
            for section in sectionsToUse{
                let sectionTotal = BudgetSectionTotals(section: section, total: 0.0)
                sectionTotals.append(sectionTotal)
            }
            
            var otherTotal = 0.0
            let name = CommonUtils.getDateTitleShort(date: startDate)
            
            
            let transactions = TransactionsCategoryFetcher.getTransactionsForDateRange(startDate: startDate, endDate: endDate)
            
            for transaction in transactions{
                
                let categoryMatches = transaction.categoryMatches?.allObjects as! [CategoryMatch]
                
                
                
                if transaction.amount < 0{
                    continue
                }
                else if categoryMatches.count == 0 && !transaction.isHidden{
                    otherTotal = otherTotal + transaction.amount
                }
                else{
                    //Horribly complex code to see what section total I should increment
                    for match in categoryMatches{
                        
                        var anyMatch = false
                        for section in sectionsToUse{
                            
                            for budgetCategory in section.getBudgetCategories(){
                                
                                if budgetCategory.spendingCategory!.id! == match.spendingCategory!.id!{
                                    
                                    
                                    for (index, sectionTotal) in sectionTotals.enumerated(){
                                        
                                        
                                        if sectionTotal.section.id! == section.id{
                                            anyMatch = true
                                            if !transaction.isHidden{
                                                sectionTotals[index].total = sectionTotals[index].total + Double(match.amount)
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                    //if !anyMatch && !transaction.isHidden{
                                    //    otherTotal = otherTotal + Double(match.amount)
                                    //}
                                    
                                   
                                }
                                
                            }
                            
                        }
                        
                    }
                }
                
                
  
            }
            
            //We've gone through every transaction in the period. Now, let's create each bar segement
            var graphSegements = [HistoryGraphBarSegment]()
            var total = 0.0
            for sectionTotal in sectionTotals {
                let segement = HistoryGraphBarSegment(color: colorMap[Int(sectionTotal.section.colorCode)], name: sectionTotal.section.name!, value: sectionTotal.total, icon: sectionTotal.section.icon!)
                graphSegements.append(segement)
                total = total + sectionTotal.total
            }
            
            if state != .Section{
                let segement = HistoryGraphBarSegment(color: globalAppTheme.otherColor, name: "Other", value: otherTotal, icon: "book")
                graphSegements.append(segement)
                total = total + otherTotal
            }
            
            graphSegements = graphSegements.sorted(by: { $0.value < $1.value })
            
            bars.append(HistoryGraphBar(label: name, totalValue: total, segments: graphSegements))
            
           endDate = Calendar.current.date(byAdding: .month, value: -1, to: endDate)!
           startDate = Calendar.current.date(byAdding: .month, value: -1, to: startDate)!
            
        }
        
        return bars
        
    }
    
    
    
    
    
    
    func generateViewData(){
        
        self.viewData = [HistoryEntryViewData]()

        
    }
    
    

}
