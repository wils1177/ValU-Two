//
//  BudgetsTabViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


struct BudgetsListWrapper : Hashable{
    static func == (lhs: BudgetsListWrapper, rhs: BudgetsListWrapper) -> Bool {
        return lhs.idx == rhs.idx
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idx)

    }
    
    var historyEntry : HistoryEntryViewData?
    var futureEntry : FutureEntryViewData?
    var sectionTitle : String?
    var futureZero : Bool?
    var historyZero : Bool?
    var idx : Int
}


class BudgetsTabViewModel : Presentor, ObservableObject {
    
    var budget : Budget
    var coordinator : BudgetsTabCoordinator?
    var historyModel : HistoryViewModel
    var historicalBudgets : [Budget] = [Budget]()
    var futureBudgets : [Budget] = [Budget]()
    @Published var viewData = [BudgetsListWrapper]()

    init(budget : Budget){
        self.budget = budget
        
        let pastQuery = PredicateBuilder().generatePastBudgetPredicate(currentDate: Date())
        let futureQuery = PredicateBuilder().generateFutureBudgetPredicate(currentDate: Date())
        
        self.historicalBudgets = try! DataManager().getBudgets(predicate: pastQuery) ?? [Budget]()
        self.futureBudgets = try! DataManager().getBudgets(predicate: futureQuery) ?? [Budget]()
        self.historyModel = HistoryViewModel(budget: self.budget, historicalBudgets: self.historicalBudgets)
    }
    
    func configure() -> UIViewController {
        generateViewData()
        
        let vc = UIHostingController(rootView: BudgetsTabView(viewModel: self))
        
        return vc
    }

    
    func testBudgetCopy(){
        let copier = BudgetCopyer()
        let oldBudget = self.budget
        let newBudget = copier.copyBudgetForNextPeriod(budget: self.budget)
        self.budget = newBudget
        
        let modifiedStartDate = Calendar.current.date(byAdding: .day, value: -30, to: oldBudget.startDate!)!
        oldBudget.startDate = modifiedStartDate
        let modifiedEndDate = Calendar.current.date(byAdding: .day, value: -30, to: oldBudget.endDate!)!
        oldBudget.endDate = modifiedEndDate
        
        self.historicalBudgets.append(oldBudget)
        
        
        
        generateViewData()
    }
    
    func userSelectedCreateNewBudgetFromScratch(){
        
        let newBudget = DataManager().createNewBudget()
        newBudget.active = false
        
        coordinator?.userSelectedCreateNewBudgetFromScratch(budget: newBudget)
        
    }
    
    func userSelectedCreateFromExistinBudget(){
        let copier = BudgetCopyer()
        let newBudget = copier.copyBudgetForUpcomming(budget: self.budget)
        
        coordinator?.userSelectedCreateFromExistinBudget(newBudget: newBudget)
    }
    
    func deleteBudget(id: UUID){
        print("this is being called")
        for budget in self.futureBudgets{
            if budget.id == id{
                
                do{
                    try DataManager().deleteEntity(predicate: PredicateBuilder().generateByIdPredicate(id: id), entityName: "Budget")
                    let futureQuery = PredicateBuilder().generateFutureBudgetPredicate(currentDate: Date())
                    self.futureBudgets = try! DataManager().getBudgets(predicate: futureQuery) ?? [Budget]()
                    generateViewData()
                }
                catch{
                    print("Could Not Delete Budget")
                }
                
            }
        }
    }
    
    
    
    
    func generateViewData(){
        
        self.viewData = [BudgetsListWrapper]()
        var idx = 0
        let upcomingBudgetsSectionTitle = "Upcoming Budgets"
        self.viewData.append(BudgetsListWrapper(historyEntry: nil, futureEntry: nil, sectionTitle: upcomingBudgetsSectionTitle, idx: idx))
        
        if self.futureBudgets.count == 0 {
            idx = idx + 1
            self.viewData.append(BudgetsListWrapper(historyEntry: nil, futureEntry: nil, sectionTitle: nil, futureZero: true, historyZero: nil, idx: idx))
        }
        
        for futureBudget in self.futureBudgets{
            idx = idx + 1
            let startDate = futureBudget.startDate!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLLL"
            let nameOfMonth = dateFormatter.string(from: startDate)
            let title = nameOfMonth
            
            let planned = futureBudget.getAmountAvailable()
            let plannedString = "$" + String(Int(round(planned)))
            
            let spendingCardModel = SpendingCardViewModel(budget: futureBudget)
            let spendingCardViewData = spendingCardModel.viewData
            
            let futureEntry = FutureEntryViewData(title: title, planned: plannedString, spendingCardViewData: spendingCardViewData, budgetId: futureBudget.id!)
            self.viewData.append(BudgetsListWrapper(historyEntry: nil, futureEntry: futureEntry, sectionTitle: nil, idx: idx))
        }
        
        idx = idx + 1
        let pastBudgetsSectionTitle = "Past Budgets"
        self.viewData.append(BudgetsListWrapper(historyEntry: nil, futureEntry: nil, sectionTitle: pastBudgetsSectionTitle, idx: idx))
        
        if self.historicalBudgets.count == 0 {
            idx = idx + 1
            self.viewData.append(BudgetsListWrapper(historyEntry: nil, futureEntry: nil, sectionTitle: nil, futureZero: nil, historyZero: true, idx: idx))
        }
        
        for pastBudget in self.historicalBudgets{
            
            idx = idx + 1
            
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
            self.viewData.append(BudgetsListWrapper(historyEntry: entry, futureEntry: nil, sectionTitle: nil, idx: idx))
        }
        
    }

}
