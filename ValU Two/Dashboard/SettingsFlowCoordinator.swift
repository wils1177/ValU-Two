//
//  SettingsFlowCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/16/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class SettingsFlowCoordinator : Coordinator, PlaidLinkDelegate, plaidIsConnectedDelegate{
    
    
    var parent : HomeTabCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var budget: Budget
    var presentorStack = [Presentor]()

    init(budget: Budget){
        self.budget = budget
    }
    
    func start(){
        
        let presentor = SettingsViewModel(budget: self.budget)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: false)
        self.navigationController.modalPresentationStyle = .fullScreen
        
        self.presentorStack.append(presentor)
        
    }
    
    func showPlaidLink(){
        let presentor = PlaidLinkViewPresentor()
        presentor.coordinator = self
        let vc = presentor.configure()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController.present(vc, animated: true)
        self.presentorStack.append(presentor)
    }
    
    func dismissPlaidLink(sender: PlaidLinkViewPresentor) {
        
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
        })
        
        _ = self.presentorStack.popLast()
        

    }
    
    func plaidLinkSuccess(sender: PlaidLinkViewPresentor) {
        
        let presentor = LoadingAccountsPresentor(budget: self.budget)
        presentor.coordinator = self
        let vc = presentor.configure()
        self.navigationController.pushViewController(vc, animated: false)
        
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
            
        })
        _ = self.presentorStack.popLast()
        
    }
    
    func plaidIsConnected() {
        self.navigationController.popViewController(animated: true)
        let settingsPresentor = self.presentorStack.last as? SettingsViewModel
        settingsPresentor?.updateView()
        self.budget.updateAmountSpent()
    }
    
    func dismissSettings(){
        
        self.navigationController.dismiss(animated: true)
        self.navigationController = UINavigationController()
        _ = self.presentorStack.popLast()
        self.parent?.dismissSettings()
        
        
    }

}
