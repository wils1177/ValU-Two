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
            DataManager().saveDatabase()
        }
        else{
            print("no active budget available!")
        }
        
 
    }
    
    
    func generateViewData(){
        
        self.viewData = [HistoryEntryViewData]()

        
    }

}
