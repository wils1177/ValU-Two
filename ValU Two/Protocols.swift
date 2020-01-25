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

protocol CategoryListViewModel: UserSubmitViewModel{
    var viewData: [BudgetCategoryViewData] { get set }
    var selectedCategoryNames : [String] {get set}
    var spendingCategories : [SpendingCategory]{get set}
    
    func deSelectedCategoryName(name:String)
    func selectedCategoryName(name:String)
}

protocol HasButtonRows {
    
    var buttonArray : [[CategoryButton]]{ get set }
    
    func generateButtonArray(buttonList: [CategoryButton]) ->[[CategoryButton]]
    
}

protocol UserSubmitViewModel: class, ViewModel{
    func submit()
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
    func dismissPlaidLink()
    func plaidLinkSuccess(sender : PlaidLinkViewPresentor)
}

protocol CardsPresentor : Presentor{
    func setupTableView()
    func submit()
}
