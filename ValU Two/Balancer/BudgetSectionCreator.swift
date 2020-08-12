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
        let newSection = dm.createBudgetSection(name: name, icon: icon, colorCode: colorCode)
        budget.addToBudgetSection(newSection)
        budget.objectWillChange.send()
        dm.saveDatabase()
    }
    
}
