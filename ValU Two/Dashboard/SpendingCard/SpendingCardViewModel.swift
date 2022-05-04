//
//  SpendingCardPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/11/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

import SwiftUI
import CoreData

enum names : String{
    case otherCategoryName = "Everything Else"
}


class SpendingCategoryViewData: Hashable, Identifiable{
    var percentage : CGFloat = CGFloat(0.0)
    var spent : Float
    var limit : Float
    var name : String = ""
    var icon : String = "🍔"
    var id = UUID()
    
    init(percentage: CGFloat, spent: Float, limit: Float, name: String, icon: String) {
        self.percentage = percentage
        self.limit = limit
        self.spent = spent
        self.name = name
        self.icon = icon
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(limit)

    }
    
    static func == (lhs: SpendingCategoryViewData, rhs: SpendingCategoryViewData) -> Bool {
        return lhs.name == rhs.name && lhs.limit == rhs.limit && rhs.id == lhs.id
    }
    
}

struct SpendingCardViewData{
    var cardTitle : String = ""
    var categories : [SpendingCategoryViewData] = [SpendingCategoryViewData]()
}

class SpendingCardViewModel: ObservableObject {
    
    var budget : Budget
    var coordinator: BudgetsTabCoordinator?
    @Published var budgetSections = [BudgetSection]()
    var budgetCategories = [BudgetCategory]()
    @Published var otherCategory : SpendingCategoryViewData?
    var viewData = SpendingCardViewData()
    var budgetTransactionsService : BudgetTransactionsService
    
    init(budget: Budget, budgetTransactionsService: BudgetTransactionsService){
        self.budget = budget
        self.budgetTransactionsService = budgetTransactionsService
        self.budgetSections = getBudgetedSections(sections: budget.getBudgetSections())
        self.budgetCategories = budget.getBudgetCategories()
    }
    
    func getBudgetedSections(sections: [BudgetSection]) -> [BudgetSection]{
        var toReturn = [BudgetSection]()
        for section in sections{
            if section.getLimit() > 0.0 {
                toReturn.append(section)
            }
        }
        return toReturn
    }
    
    
    
    
    func editBudget(){
        self.coordinator?.editClicked(budgetToEdit: self.budget)
    }
    
    func getOtherSpent() -> Float{
        
        return Float(self.budgetTransactionsService.getOtherSpentTotal())
    }
    
    func getRemainig() -> Int {
        return Int(self.budget.getAmountAvailable() - Float(self.budgetTransactionsService.getBudgetExpenses()))
    }
    

    
    /*
    @objc func update(_ notification:Notification){
        print("Spending Card Update Triggered")
        let dataManager = DataManager()
        dataManager.context.refreshAllObjects()
        
        
        //generateViewData()
        self.viewData = SpendingCardViewData()
        self.generateViewData()
        
    }
    */

    
    
    
    
    
    
    
    
}
