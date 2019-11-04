//
//  presentorProtocol.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/20/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit

protocol Presentor {
    func configure() -> UIViewController
}

protocol CreateBudgetPresentorDelegate {
    func budgetSubmitted(budget : Budget, sender: CreateBudgetFormPresentor)
}

protocol CreateBudgetVCDelegate {
    func userSelectedCTA(viewData: CreateBudgetFormViewRep)
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