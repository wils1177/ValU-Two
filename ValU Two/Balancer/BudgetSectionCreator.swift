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
    
    var editMode: Bool = false
    var existingSection: BudgetSection?
    
    init(budget: Budget, editMode: Bool = false, existingSection: BudgetSection? = nil){
        self.existingSection = existingSection
        self.editMode = editMode
        self.budget = budget
    }
    
    func editBudgetSection(name: String, icon: String, colorCode: Int){
        self.existingSection!.name = name
        self.existingSection!.icon = icon
        self.existingSection!.colorCode = Int32(colorCode)
        DataManager().saveDatabase()
    }
    
    func createNewSection(name: String, icon: String, colorCode: Int){
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
    
    func addSectionToBudget(name: String, icon: String, colorCode: Int){
        
        if editMode{
            self.editBudgetSection(name: name, icon: icon, colorCode: colorCode)
        }
        else{
            self.createNewSection(name: name, icon: icon, colorCode: colorCode)
        }
        
    }
    
}
