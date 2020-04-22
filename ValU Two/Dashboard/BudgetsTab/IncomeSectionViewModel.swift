//
//  IncomeSectionViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class IncomeSectionViewModel{
    
    var totalIncome = 0.0
    var expectedIncome = 0.0
    var percentage = 0.0
    var budget : Budget
    
    init(budget: Budget){
        self.budget = budget
        self.expectedIncome = Double(self.budget.amount)
        getTotalIncome()
        if expectedIncome != 0.0{
            self.percentage = self.totalIncome / expectedIncome
        }
    }
    
    func getTotalIncome(){
        
        self.totalIncome = 0.0
        for transaction in self.budget.transactions?.allObjects as! [Transaction]{
            if transaction.amount < 0{
                self.totalIncome = self.totalIncome + (transaction.amount * -1)
            }
        }
        
    }
    
}
