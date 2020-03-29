//
//  presentorProtocol.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/20/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit
import SwiftUI

protocol Presentor {
    func configure() -> UIViewController
}

protocol ViewModel{
    func generateViewData()
}

protocol BudgetDateFindable{
    var budget : Budget {get set}
    
    func isWithinBudgetDates(transactionDate: Date) -> Bool
}

protocol CategorySelecter: class{
    var selectedCategoryNames : [String] {get set}
    var spendingCategories : [SpendingCategory]{get set}
    var budget : Budget? {get set}
    
    func deSelectedCategoryName(name:String)
    func selectedCategoryName(name:String)
    func submit()
    
}

protocol CategoryListViewModel: UserSubmitViewModel, CategorySelecter{
    var viewData: [BudgetCategoryViewData] { get set }
       
}

protocol KeyboardDelegate{
    func onKeyBoardSet(text : String, key: String?)
}

protocol HasButtonRows {
    
    var buttonArray : [[CategoryButton]]{ get set }
    
    func generateButtonArray(buttonList: [CategoryButton]) ->[[CategoryButton]]
    
}

protocol UserSubmitViewModel: class, ViewModel{
    func submit()
}

protocol plaidIsConnectedDelegate{
    func plaidIsConnected()
}


protocol StartPageViewDelegate {
    func continueToOnboarding()
}

protocol SetSavingsViewDelegate {
    func savingsSubmitted(budget : Budget, sender: SetSavingsPresentor)
}

protocol BudgetCategoriesDelegate {
    func categoriesSubmitted()
}

protocol SetSpendingLimitDelegate {
    func finishedSettingLimits()
}


protocol PlaidLinkDelegate {
    func dismissPlaidLink(sender: PlaidLinkViewPresentor)
    func plaidLinkSuccess(sender : PlaidLinkViewPresentor)
}

protocol CardsPresentor : Presentor{
    func setupTableView()
    func submit()
}

protocol TransactionRowDelegate: class {
    func showEditCategory(transaction: Transaction)
    func dismissEditCategory()
    
    var navigationController : UINavigationController{ get set }
    var presentorStack : [Presentor]{ get set }
    var budget: Budget{ get set }
}

protocol IncomeCoordinator: Coordinator {
    
    var budget : Budget? {get set}
    
    
    func loadIncomeScreen()
    func incomeSubmitted(budget: Budget, sender: EnterIncomePresentor)
}

protocol BudgetEditor {
    
    func editIncome()
    func editBudget()
    func editSavings()
    func dismiss()
    
    var coordinator : BudgetEditableCoordinator? {get set}
    var viewData : EditBudgetViewData? {get set}
    
}

protocol BudgetEditableCoordinator: IncomeCoordinator, SetSavingsViewDelegate, SetSpendingLimitDelegate{
    func editBudgetCategories()
    func continueToSetSavings()
    func setMonth()
    func dimiss()
}




extension BudgetDateFindable{
    
    func isWithinBudgetDates(transactionDate: Date) -> Bool{
        
        let startDate = self.budget.startDate
        let endDate = self.budget.endDate
        
        return (startDate! ... endDate!).contains(transactionDate)
        
    }
    
}
