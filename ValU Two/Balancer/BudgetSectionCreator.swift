//
//  BudgetSectionCreator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/28/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class BudgetSectionCreator{
    
    var budget: Budget
    
    init(budget: Budget){
        self.budget = budget
    }
    
    func addSectionToBudget(name: String, icon: String, colorCode: Int){
        let dm = DataManager()
        
        let sections = self.budget.budgetSection?.allObjects as! [BudgetSection]
        var maxOrder = 0
        
        for section in sections{
            if section.order > maxOrder{
                maxOrder = Int(section.order)
            }
        }
        
        let order = maxOrder + 1
        let newSection = dm.createBudgetSection(name: name, icon: icon, colorCode: colorCode, order: Int(order))
        budget.addToBudgetSection(newSection)
        budget.objectWillChange.send()
        dm.saveDatabase()
    }
    
}
