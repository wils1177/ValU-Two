//
//  AppCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator{
    
    // App Dependencies
    var currentBudget : Budget?
    
    // Member Variables
    var childCoordinators = [Coordinator]()
    let navigationController : UINavigationController
    
    
    init(rootViewController: UINavigationController){
        self.navigationController = rootViewController
    }
    
    func start(){
        
        if currentBudget == nil{
            showOboardingFlow()
        }
    }
    
    private func showOboardingFlow(){
        print("display the onboarding flow")
        let onboardingCoordinator = OnboardingFlowCoordinator(navigationController:  self.navigationController)
        onboardingCoordinator.parent = self
        self.childCoordinators.append(onboardingCoordinator)
        
        onboardingCoordinator.start()
    }
    
    func startDashboard(){
        
        //let dasboardCoordinator = DasboardCoordinator(tabBarController: self.navigationController)
        //dasboardCoordinator.parent = self
        //self.childCoordinators.append(dasboardCoordinator)
        
        //dasboardCoordinator.start()
        
    }
    
}
