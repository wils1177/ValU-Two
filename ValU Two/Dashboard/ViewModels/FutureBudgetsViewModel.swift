//
//  FutureBudgetsViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/21/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class FutureEntryViewData: Hashable{
    var title = "test"
    var planned: String
    var spendingCardViewData: SpendingCardViewData
    var id = UUID()
    var budgetId : UUID
    
    init(title : String, planned: String, spendingCardViewData: SpendingCardViewData, budgetId: UUID){
        self.title = title
        self.planned = planned
        self.spendingCardViewData = spendingCardViewData
        self.budgetId = budgetId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FutureEntryViewData, rhs: FutureEntryViewData) -> Bool {
        return lhs.id == rhs.id
    }
    
}

class FutureBudgetsViewModel : ObservableObject {

    var budget : Budget
    var futureBudgets : [Budget]?
    var coordinator : BudgetsTabCoordinator?
    @Published var viewData = [FutureEntryViewData]()

    init(budget : Budget, futureBudgets: [Budget]){
        self.budget = budget
        self.futureBudgets = futureBudgets
        
    } 


    func generateViewData(){
        
        self.viewData = [FutureEntryViewData]()
        for futureBudget in self.futureBudgets!{
            
            let available = futureBudget.getAmountAvailable()
            
            let planned = "$" + String(Int(round(available)))
            let startDate = futureBudget.startDate!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLLL"
            let nameOfMonth = dateFormatter.string(from: startDate)
            let title = nameOfMonth
            
            let spendingCardModel = SpendingCardViewModel(budget: futureBudget)
            let spendingCardViewData = spendingCardModel.viewData
            
            let entry = FutureEntryViewData(title: title, planned: planned, spendingCardViewData: spendingCardViewData, budgetId: futureBudget.id!)
            self.viewData.append(entry)
        }
        
    }
    
}
