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
    
    
    weak var coordinator : BudgetsTabCoordinator?
    var spendingModel : SpendingCardViewModel?
    var budgetTransactionsService : BudgetTransactionsService
    @Published var currentBudget : Budget
    @Published var selected = 0
    
    init(budget: Budget, coordinator: BudgetsTabCoordinator? = nil, service: BudgetTransactionsService){
        self.currentBudget = budget
        self.coordinator = coordinator
        self.budgetTransactionsService = service
        self.spendingModel = generateSpendingCardViewModel(budget: budget)
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
    }
    
    @objc func update(_ notification:Notification){
        print("Spending Card Update Triggered")
        let dataManager = DataManager()
        dataManager.context.refreshAllObjects()
        
        
        
    }
    
    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: BudgetsView(viewModel: self, budget: self.currentBudget))
        return vc
    }
    

    func generateSpendingCardViewModel(budget: Budget) -> SpendingCardViewModel{
        let viewModel = SpendingCardViewModel(budget: budget, budgetTransactionsService: self.budgetTransactionsService)
        viewModel.coordinator = self.coordinator
        return viewModel
    }
    
    func clickedSettingsButton(){
        self.coordinator?.settingsClicked()
    }
    
    func editBudget(budget: Budget){
        self.coordinator?.editClicked(budgetToEdit: budget)
    }
    
    
    func testBudgetCopy(budget: Budget){
        
        let copier = BudgetCopyer()
        let oldBudget = budget
        let newBudget = copier.copyBudgetForNextPeriod(budget: budget)
        
        let modifiedStartDate = Calendar.current.date(byAdding: .day, value: -30, to: oldBudget.startDate!)!
        oldBudget.startDate = modifiedStartDate
        let modifiedEndDate = Calendar.current.date(byAdding: .day, value: -30, to: oldBudget.endDate!)!
        oldBudget.endDate = modifiedEndDate
        
        //self.historicalBudgets.append(oldBudget)
        
        
        
    }
    
    func getBudgetStatusBarViewData() -> [BudgetStatusBarViewData]{
        print("getting budget status bar view data")
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
            let data = BudgetStatusBarViewData(percentage: spentInSection / Double(total), color: colorMap[Int(section.colorCode)], name: section.name!, icon: section.icon!, action: self.coordinator?.showIndvidualBudget(budgetSection:), section: section)
            
            
            if limitForSection > 0.0 && spentInSection > 0.0{
                viewDataToReturn.append(data)
            }
            
        }
        
        
        
        
        let otherPercentage = Float(otherTotal) / total
        let otherData = BudgetStatusBarViewData(percentage: Double(otherPercentage), color: AppTheme().otherColor, name: "Other", icon: "book")
        viewDataToReturn.append(otherData)
        
        viewDataToReturn.sort(by: { $0.percentage > $1.percentage })
        
        
        if !(spentTotal > Double(amountAvailable)){
            viewDataToReturn.sort(by: { $0.percentage > $1.percentage })
            let remainingPercentage = Float((total - Float(spentTotal)) / total)
            let remainingData = BudgetStatusBarViewData(percentage: Double(remainingPercentage), color: Color(#colorLiteral(red: 0.9543517232, green: 0.9543194175, blue: 0.9847152829, alpha: 1)), name: "Remaining", icon: "folder")
            viewDataToReturn.append(remainingData)
        }
        
        
        
        
        
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
    
    func getRemaining() -> Int {
        
        let remaining = Int(self.currentBudget.getAmountAvailable() - Float(self.budgetTransactionsService.getBudgetExpenses()))
        
        return remaining
    
    }

    
}
