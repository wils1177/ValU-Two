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
            
            
            
            
            let total = earnedTotal - spentTotal
            
            
            let income = HistoryGraphBarSegment(color: Color(.systemGreen), name: "Income", startDate: startDate, value: earnedTotal, icon: "arrow.up")
                
                graphSegements.append(income)
            
            
            let outcome = HistoryGraphBarSegment(color: Color(.systemRed), name: "Spending", startDate: startDate, value: spentTotal, icon: "arrow.down")
                 
                 graphSegements.append(outcome)
            
                
            data.append(HistoryGraphBar(label: name, totalValue: total, segments: graphSegements))
            
           endDate = Calendar.current.date(byAdding: .month, value: -1, to: endDate)!
           startDate = Calendar.current.date(byAdding: .month, value: -1, to: startDate)!
  
            }
        
        return data
        
    }
    
    
    
    
    
    
    func createSpendingGraphData(state: HistoryGraphViewState, budgetSection: BudgetSection?) -> [HistoryGraphBarSegment]{
        
        
        
       
        return createGraphDataforSection(section: budgetSection)
        
    }
    
    
    func createGraphDataforSection(section: BudgetSection?) -> [HistoryGraphBarSegment]{
        let periods = 5
        
        var endDate = Date().endOfMonth!
        
        var startDate = Date().startOfMonth!
        
        var segments = [HistoryGraphBarSegment]()
        
        for _ in 1...periods{
            
            let total = getSpendingTotalForSectionAndDate(section: section, startDate: startDate, endDate: endDate)
            let name = CommonUtils.getDateTitleShort(date: startDate)
            
            if section == nil{
                let segment = HistoryGraphBarSegment(color: globalAppTheme.themeColorPrimary, name: name, startDate: startDate, value: total)
                segments.append(segment)
            }
            else{
                let segment = HistoryGraphBarSegment(color: colorMap[Int(section!.colorCode)], name: name, startDate: startDate, value: total)
                segments.append(segment)
            }

            
            
            endDate = Calendar.current.date(byAdding: .month, value: -1, to: endDate)!
            startDate = Calendar.current.date(byAdding: .month, value: -1, to: startDate)!
            
        }
        
        return segments
    }
    
    func getSpendingTotalForSectionAndDate(section: BudgetSection?, startDate: Date, endDate: Date) -> Double{
        
        let transactions = TransactionsCategoryFetcher.getTransactionsForDateRange(startDate: startDate, endDate: endDate)
        
        var total = 0.0
        
        for transaction in transactions{
            
            let categoryMatches = transaction.categoryMatches?.allObjects as! [CategoryMatch]
            
            if transaction.amount < 0{
                continue
            }
            
            for match in categoryMatches{
                
                if section != nil{
                    for budgetCategory in section!.getBudgetCategories(){
                        
                        if budgetCategory.spendingCategory!.id! == match.spendingCategory!.id!{
                            
                            if transaction.isHidden != true{
                                total = total + Double(match.amount)
                            }
                            
                            
                        }
                        
                    }
                }
                else{
                    for match in categoryMatches{
                        
                        if transaction.isHidden != true{
                            total = total + Double(match.amount)
                        }
                        
                        
                    }
                }
                
                
                
            }
            
            
            
        }
        
        return total
        
        
        
    }
    
    
    
    
    
    
    
    
    func generateViewData(){
        
        self.viewData = [HistoryEntryViewData]()

        
    }
    
    

}
