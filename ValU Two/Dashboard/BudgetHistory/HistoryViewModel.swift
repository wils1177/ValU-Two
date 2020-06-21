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
    
    var budget : Budget
    @Published var historicalBudgets : [Budget]
    var coordinator : MoneyTabCoordinator?
    var viewData = [HistoryEntryViewData]()
    
    var service : BudgetStatsService

    init(budget : Budget){
        self.budget = budget
        
        let pastQuery = PredicateBuilder().generatePastBudgetPredicate(currentDate: Date())
        
        let budgets = try! DataManager().getBudgets(predicate: pastQuery)
        self.historicalBudgets = budgets
        self.service = BudgetStatsService(budgets: budgets)
        generateViewData()
    }
    
    
    
    
    func testBudgetCopy(){
        
        let copier = BudgetCopyer()
        let oldBudget = self.budget
        let newBudget = copier.copyBudgetForNextPeriod(budget: self.budget)
        self.budget = newBudget
        self.historicalBudgets.append(oldBudget)
        DataManager().saveDatabase()
 
    }
    
    
    func generateViewData(){
        
        self.viewData = [HistoryEntryViewData]()
        for pastBudget in self.historicalBudgets{
            
            let available = pastBudget.getAmountAvailable()
            let spendValue = pastBudget.spent
            
            let remaining = "$" + String(Int(round(available - spendValue)))
            let spent = "$" + String(Int(round(spendValue)))
            let percentage = CGFloat(spendValue / available)
            let startDate = pastBudget.startDate!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLLL"
            let nameOfMonth = dateFormatter.string(from: startDate)
            let title = nameOfMonth
            
            let spendingCardModel = SpendingCardViewModel(budget: pastBudget)
            let spendingCardViewData = spendingCardModel.viewData
            
            let entry = HistoryEntryViewData(title: title, spent: spent, remaining: remaining, percentage: percentage, spendingCardViewData: spendingCardViewData)
            self.viewData.append(entry)
        }
        
    }

}
