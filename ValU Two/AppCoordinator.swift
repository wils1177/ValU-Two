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
    let tabBarController : DashboardTabBarController
    let userDefaults = UserDefaults.standard
    
    
    init(rootViewController: DashboardTabBarController){
        self.tabBarController = rootViewController
        
    }
    
    func start(){
                
        
        
    }
    
    // This will determine what to show when the dashboard is loaded.
    func loadDashboard(){
        print("called!!")
        if userDefaults.object(forKey: "UserOnboarded") == nil {
            showOboardingFlow()
        }
        
    }
    
    
    
    private func showOboardingFlow(){
        
        print("Starting Onboarding Flow")
        let nav = UINavigationController()
        nav.modalPresentationStyle = .fullScreen
        self.tabBarController.present(nav, animated: false)
        let onboardingCoordinator = OnboardingFlowCoordinator(navigationController: nav)
        onboardingCoordinator.parent = self
        childCoordinators.append(onboardingCoordinator)
        onboardingCoordinator.start()
        
    }
    
    func onboardingComplete(_ child: Coordinator){
        
        DataManager().saveDatabase()
        userDefaults.set(true, forKey: "UserOnboarded")
        
        print("onboarding completed")
        
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
        
        self.tabBarController.setUpViews()
        
    }
    
    
    
}
