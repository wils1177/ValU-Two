//
//  HomePresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/10/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

import UIKit
import SwiftUI

struct HomeViewData{
    var budgetCardViewModel : BudgetCardViewModel
    var spendingCardViewModel : SpendingCardViewModel
}

class HomeViewModel: ObservableObject, Presentor{
    
    
    var budget : Budget
    @Published var viewData : HomeViewData?
    var coordinator : HomeTabCoordinator?
    
    init(budget : Budget){
        self.budget = budget
        
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
        
        
    }
    
    @objc func update(_ notification:Notification){
        print("Spending Card Update Triggered")
        let dataManager = DataManager()
        dataManager.context.refreshAllObjects()
        
        
        //generateViewData()
        self.viewData = nil
        self.generateViewData()
        
    }
    
    func configure() -> UIViewController {
        generateViewData()
        return UIHostingController(rootView: HomeView(viewModel: self))
    }
    
    func generateViewData(){
        
        let budgetcardViewModel = BudgetCardViewModel(budget: self.budget)        
        let spendingCardViewModel = SpendingCardViewModel(budget: self.budget)
        spendingCardViewModel.coordinator = self.coordinator
        
        let viewData = HomeViewData(budgetCardViewModel: budgetcardViewModel, spendingCardViewModel: spendingCardViewModel)
        
        self.viewData = viewData

    
    }
    
    func clickedSettingsButton(){
        self.coordinator?.settingsClicked()
    }
    
    func clickedEdit(){
        self.coordinator?.editClicked()
    }

    
}
