//
//  HomePresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/10/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

import UIKit
import SwiftUI

class BudgetsViewModel: ObservableObject, Presentor{
    
    
    var coordinator : BudgetsTabCoordinator
    var spendingModel : SpendingCardViewModel?
    var budgetTransactionsService : BudgetTransactionsService
    @Published var futureBudgets  = [BudgetTimeFrame]()
    @Published var historicalBudgets = [Budget]()
    @Published var currentBudget : Budget
    @Published var selected = 0
    
    init(budget: Budget, budgetService: BudgetTransactionsService, coordinator: BudgetsTabCoordinator){
        self.currentBudget = budget
        self.coordinator = coordinator
        self.budgetTransactionsService = budgetService
        self.spendingModel = generateSpendingCardViewModel(budget: budget, coordinator: coordinator)
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
    }
    
    @objc func update(_ notification:Notification){
        print("Spending Card Update Triggered")
        let dataManager = DataManager()
        dataManager.context.refreshAllObjects()
        
        
        
    }
    
    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: BudgetsView(viewModel: self))
        return vc
    }
    

    func generateSpendingCardViewModel(budget: Budget, coordinator: BudgetsTabCoordinator) -> SpendingCardViewModel{
        let viewModel = SpendingCardViewModel(budget: budget, budgetTransactionsService: self.budgetTransactionsService)
        viewModel.coordinator = coordinator
        return viewModel
    }
    
    func clickedSettingsButton(){
        self.coordinator.settingsClicked()
    }
    
    func editBudget(budget: Budget){
        self.coordinator.editClicked(budgetToEdit: budget)
    }
    
    
    func testBudgetCopy(budget: Budget){
        let copier = BudgetCopyer()
        let oldBudget = budget
        let newBudget = copier.copyBudgetForNextPeriod(budget: budget)
        
        let modifiedStartDate = Calendar.current.date(byAdding: .day, value: -30, to: oldBudget.startDate!)!
        oldBudget.startDate = modifiedStartDate
        let modifiedEndDate = Calendar.current.date(byAdding: .day, value: -30, to: oldBudget.endDate!)!
        oldBudget.endDate = modifiedEndDate
        
        self.historicalBudgets.append(oldBudget)
        
        
        
    }
    
    func getBudgetStatusBarViewData() -> [BudgetStatusBarViewData]{
        
        var viewDataToReturn = [BudgetStatusBarViewData]()
        let amountAvailable = self.currentBudget.getAmountAvailable()
        let spentTotal = self.budgetTransactionsService.getBudgetExpenses()
        let otherTotal = self.budgetTransactionsService.getOtherSpentTotal()
        var total = amountAvailable
        
        if spentTotal > Double(amountAvailable){
            total = Float(spentTotal)
        }
        

        
        var sectionSpentTotal = 0.0
        for section in self.currentBudget.getBudgetSections(){
            let spentInSection = section.getSpent()
            let limitForSection = section.getLimit()
            sectionSpentTotal = spentInSection + sectionSpentTotal
            let data = BudgetStatusBarViewData(percentage: spentInSection / Double(total), color: colorMap[Int(section.colorCode)], name: section.name!)
            
            if limitForSection > 0.0 && spentInSection > 0.0{
                viewDataToReturn.append(data)
            }
            
        }
        
        viewDataToReturn.sort(by: { $0.percentage > $1.percentage })
        
        let percentage = Float(otherTotal) / total
        let otherData = BudgetStatusBarViewData(percentage: Double(percentage), color: Color(.lightGray), name: "Other")
        viewDataToReturn.append(otherData)
        
        return viewDataToReturn
    }
    
    

    func deleteBudget(id: UUID){
            do{
                try DataManager().deleteEntity(predicate: PredicateBuilder().generateByIdPredicate(id: id), entityName: "Budget")
                print("budget deleted")
            }
            catch{
                print("Could Not Delete Budget")
            }
 
    }

    
}
