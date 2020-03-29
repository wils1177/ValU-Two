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
    var homeTabCoordinator : HomeTabCoordinator?
    var historyTabCoordinator : BudgetsTabCoordinator?
    var transactionTabCoordinator : TransactionsTabCoordinator?
    
    
    var budget: Budget?


    
    override func viewWillAppear(_ animated: Bool) {
        
        setupViews()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }
    
    //The parent coorindator will decide what we load over the dashboard, if anything
    override func viewDidAppear(_ animated: Bool) {
        self.parentCoordinator?.loadDashboard()
        

    }
    

    
    func setupViews(){
        
        self.budget = try? DataManager().getBudget()
        
        if self.budget == nil || UserDefaults.standard.object(forKey: "UserOnboarded") == nil{
            print("Not onboarded Yet")
            let vc = UIHostingController(rootView: CouldNotLoadView(errorMessage: "Could not Load Budget! Sorry!"))
            viewControllers = [vc]
        }
        else{
            print("User Is Onboarded")
            self.homeTabCoordinator = HomeTabCoordinator(budget: self.budget!)
            self.transactionTabCoordinator = TransactionsTabCoordinator(budget: self.budget!)
            self.historyTabCoordinator = BudgetsTabCoordinator(budget: self.budget!)
            
            self.homeTabCoordinator?.start()
            self.transactionTabCoordinator?.start()
            self.historyTabCoordinator?.start()
            
            
            viewControllers = [self.homeTabCoordinator!.navigationController, self.transactionTabCoordinator!.navigationController, self.historyTabCoordinator!.navigationController]
        }
        
        
        
        
        
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
