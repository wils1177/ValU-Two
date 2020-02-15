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
    let homeTabCoordinator = HomeTabCoordinator()
    let transactionTabCoordinator = TransactionsTabCoordinator()


    
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
        
        self.homeTabCoordinator.start()
        self.transactionTabCoordinator.start()
        viewControllers = [self.homeTabCoordinator.homeView!, self.transactionTabCoordinator.view!]
        
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
