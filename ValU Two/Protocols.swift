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
}

protocol BudgetDateFindable{
    var budget : Budget {get set}
    
    func isWithinBudgetDates(transactionDate: Date) -> Bool
}

protocol CategorySelecter: class{
    var spendingCategories : [SpendingCategory]{get set}
    var budget : Budget? {get set}
    
    func deSelectedCategoryName(name:String)
    func selectedCategoryName(name:String)
    func submit()
    
}

protocol CategoryListViewModel: UserSubmitViewModel, ObservableObject{
    func selectedCategoryName(name:String)
    func deSelectedCategoryName(name:String)
    func isSelected(name: String) -> Bool
    
}

protocol KeyboardDelegate{
    func onKeyBoardSet(text : String, key: String?)
}



protocol UserSubmitViewModel: class, ViewModel{
    func submit()
}




protocol StartPageViewDelegate {
    func continueToOnboarding()
}

protocol SetSavingsViewDelegate {
    func savingsSubmitted(budget : Budget, sender: SetSavingsPresentor)
    func userTappedCustomSavings(presentor: SetSavingsPresentor)
}

protocol BudgetCategoriesDelegate {
    func categoriesSubmitted()
}

protocol SetSpendingLimitDelegate {
    func finishedSettingLimits()
    func showCategoryDetail(budgetSection: BudgetSection, service: BalanceParentService)
    func showNewSectionView()
    
}

protocol BudgetTypeDelegate{
    func continueToBudgetType()
    func confirmBudgetType()
}


protocol PlaidLinkDelegate {
    func launchPlaidLink()
    func dismissPlaidLink(sender: PlaidLinkViewPresentor)
    func plaidLinkSuccess(sender : PlaidLinkViewPresentor)
    func plaidIsConnected()
    func connectMoreAccounts()
}

protocol CardsPresentor : Presentor{
    func setupTableView()
    func submit()
}

protocol TransactionRowDelegate: class {
    func showEditCategory(transaction: Transaction)
    func dismissEditCategory()
    func showTransactionDetail(transaction: Transaction)
    
    var navigationController : UINavigationController{ get set }
    var presentorStack : [Presentor]{ get set }
    var budget : Budget? {get set}
}

protocol IncomeCoordinator: Coordinator {
    
    var budget : Budget? {get set}
    
    
    func loadIncomeScreen()
    func incomeSubmitted(budget: Budget)
    func continueToTimeFrame()
    func timeFrameSubmitted()
    func showIncomeTransactions(transactions: [Transaction])
}

protocol BudgetEditor {
    
    func editIncome()
    func editBudget()
    func editSavings()
    func dismiss()
    
    func getTimeFrameDescription() -> String
    
    
    var coordinator : BudgetEditableCoordinator? {get set}
    var budget: Budget {get set}
    
}

protocol BudgetEditableCoordinator: IncomeCoordinator, SetSavingsViewDelegate, SetSpendingLimitDelegate, BudgetTypeDelegate, TransactionRowDelegate{
    func continueToBudgetCategories()
    func continueToPlaid()
    func continueToSetSavings()
    
    
    func dimiss()
}



protocol EditBudgetDelegate{
    func showEdit(budgetToEdit: Budget)
}

protocol NewBudgetModel: ObservableObject{
    func generateViewData()
    func getAction(stage: Int) -> (()->Void)?
    
    var currentStep : Int {get set}
    var budget : Budget {get set}
    
    var viewData : OnboardingSummaryViewData? {get set}
}




extension BudgetDateFindable{
    
    func isWithinBudgetDates(transactionDate: Date) -> Bool{
        
        let startDate = self.budget.startDate
        let endDate = self.budget.endDate
        
        return (startDate! ... endDate!).contains(transactionDate)
        
    }
    
}
