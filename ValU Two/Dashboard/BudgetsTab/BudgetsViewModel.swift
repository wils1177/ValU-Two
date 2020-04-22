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
    
    
    var coordinator : BudgetsTabCoordinator?
    var spendingModel : SpendingCardViewModel?
    @Published var futureBudgets  = [BudgetTimeFrame]()
    @Published var historicalBudgets = [Budget]()
    @Published var currentBudget : Budget?
    @Published var selected = 0
    
    init(){
        generateViewData()
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
    }
    
    @objc func update(_ notification:Notification){
        print("Spending Card Update Triggered")
        let dataManager = DataManager()
        dataManager.context.refreshAllObjects()
        
        
        self.generateViewData()
        
    }
    
    func configure() -> UIViewController {
        generateViewData()
        let vc = UIHostingController(rootView: BudgetsView(viewModel: self))
        //vc.title = "Home"
        return vc
    }
    
    func generateViewData(){
        
        let pastQuery = PredicateBuilder().generatePastBudgetPredicate(currentDate: Date())
        self.historicalBudgets = try! DataManager().getBudgets(predicate: pastQuery) ?? [Budget]()
        
        let futureQuery = PredicateBuilder().generateFutureBudgetPredicate(currentDate: Date())
        self.futureBudgets = try! DataManager().getEntity(predicate: futureQuery, entityName: "BudgetTimeFrame") as! [BudgetTimeFrame]
        self.futureBudgets = self.futureBudgets.sorted(by: {$0.startDate!.compare($1.startDate!) == .orderedAscending})

        
        let presentQuery = PredicateBuilder().generateInBetweenDatesPredicate(executionDate: Date())
        let results = try! DataManager().getEntity(predicate: presentQuery, entityName: "BudgetTimeFrame") as! [BudgetTimeFrame]
        self.currentBudget = results.first!.budget!
        
        self.spendingModel = SpendingCardViewModel(budget: self.currentBudget!)
    
    }
    
    func generateSpendingCardViewModel(budget: Budget) -> SpendingCardViewModel{
        let viewModel = SpendingCardViewModel(budget: budget)
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
        
        self.historicalBudgets.append(oldBudget)
        
        
        
        generateViewData()
    }
    
    
    
    func userSelectedToCreateNewBudget(timeFrame: BudgetTimeFrame){
        print("selected new budget")
        
        let newBudget = DataManager().createNewBudget()
        newBudget.budgetTimeFrame = timeFrame
        newBudget.active = false
        
        self.coordinator?.makeNewBudget(budget: newBudget)
    }
    
    func deleteBudget(id: UUID){
            do{
                try DataManager().deleteEntity(predicate: PredicateBuilder().generateByIdPredicate(id: id), entityName: "Budget")
                generateViewData()
                print("budget deleted")
            }
            catch{
                print("Could Not Delete Budget")
            }
 
    }

    
}
