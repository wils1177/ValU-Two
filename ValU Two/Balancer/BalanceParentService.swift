//
//  BalanceParentService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class BalanceParentService : ObservableObject, Hashable{
    
    @Published var parent : BudgetSection
    
    var id = UUID()
    
    init(budgetSection: BudgetSection){
        self.parent = budgetSection
    }
    
    func getParentLimit() -> Double{
        
        self.parent.getLimit()
    }
    
    func getParentSpent() -> Double{
        
        self.parent.getSpent()
    }
    
    func getParentInitialSpent() -> Double{
        self.parent.getInitialSpent()
    }
    
    func getPercentageSpent() -> Double{
        self.parent.getPercentageSpent()
        
    }
    
    
    func deleteCategory(id: UUID) {
        
        for category in self.parent.budgetCategories?.allObjects as! [BudgetCategory]{
            if category.id! == id{
                self.parent.removeFromBudgetCategories(category)
                let predicate = PredicateBuilder().generateByIdPredicate(id: category.id!)
                category.spendingCategory!.objectWillChange.send()
                self.objectWillChange.send()
                do{
                    try DataManager().deleteEntity(predicate: predicate, entityName: "BudgetCategory")
                }
                catch{
                    print("WARNING: Could delete budget category entity")
                }
            
                
            }
        }
        self.objectWillChange.send()
        self.parent.budget!.objectWillChange.send()
        
    }
    
    
    static func == (lhs: BalanceParentService, rhs: BalanceParentService) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    
}
