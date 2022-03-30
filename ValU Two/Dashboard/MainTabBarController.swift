//
//  MainTabBarController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/13/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import UIKit
import SwiftUI

class MainTabBarController: UITabBarController {
    
    var parentCoordinator : AppCoordinator?
    var homeTabCoordinator : BudgetsTabCoordinator?
    var moneyTabCoordinator : MoneyTabCoordinator?
    var transactionTabCoordinator : TransactionsTabCoordinator?
    var historyTabCoordinator : HistoryTabCoordiantor?
    
    
    var budget: Budget?
    var setupCount = 0
    var onboardingCanLaod = false

    
    override func viewWillAppear(_ animated: Bool) {
        UITabBar.appearance().tintColor = AppTheme().themeColorPrimaryUIKit
        if onboardingCanLaod{
            
            setupViews()
            onboardingCanLaod = false
        }
        //self.tabBar.barTintColor = UIColor(Color(hex:"FFF0E6"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    //The parent coorindator will decide what we load over the dashboard, if anything
    override func viewDidAppear(_ animated: Bool) {
        
        if setupCount < 1{
            
            setupViews()
            setupCount = setupCount + 1
        }
        self.parentCoordinator?.loadDashboard()

    }
    

    
    func setupViews(){
        
        /*
        self.moneyTabCoordinator?.stop()
        self.transactionTabCoordinator?.stop()
        self.moneyTabCoordinator?.stop()
        self.historyTabCoordinator?.stop()
        */
        
        
        

            print("User Is Onboarded")
        if self.homeTabCoordinator == nil{
            self.homeTabCoordinator = BudgetsTabCoordinator()
            homeTabCoordinator?.parent = self
        }
        self.homeTabCoordinator?.start()
        
        
        if self.transactionTabCoordinator == nil{
            self.transactionTabCoordinator = TransactionsTabCoordinator()
            
        }
        self.transactionTabCoordinator?.start()
            
        if self.moneyTabCoordinator == nil {
            self.moneyTabCoordinator = MoneyTabCoordinator()
            
        }
        self.moneyTabCoordinator?.start()
        
        if self.historyTabCoordinator == nil {
            self.historyTabCoordinator = HistoryTabCoordiantor()
            self.historyTabCoordinator?.start()
        }
        
            
            viewControllers = [self.homeTabCoordinator!.navigationController, self.transactionTabCoordinator!.navigationController, self.moneyTabCoordinator!.navigationController, self.historyTabCoordinator!.navigationController]
        
        
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
