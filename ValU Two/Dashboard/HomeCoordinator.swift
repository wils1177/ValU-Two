//
//  DashboardCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/3/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class HomeCoordinator: Coordinator{
    
    // Member Variables
    var childCoordinators = [Coordinator]()
    let navigationController : UINavigationController
    weak var parent: AppCoordinator?
    
    //Context
    var budget : Budget?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
        
        self.budget = try? DataManager().getBudget()
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start(){
        print("starting up home tab")
        
        if self.budget == nil{
            
            let vc = HomeViewZeroStateViewController()
            let containerVC = HomeContainerViewController(vc: vc)
            self.navigationController.pushViewController(containerVC, animated: false)
            //vc.coordinator = self
            
        }
        else{
            let vc = HomePresentor(budget: self.budget!).configure()
            self.navigationController.pushViewController(vc, animated: false)
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    

}
