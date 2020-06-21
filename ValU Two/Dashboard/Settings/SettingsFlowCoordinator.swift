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

class SettingsFlowCoordinator : Coordinator, PlaidLinkDelegate{
    
    
    var parent : BudgetsTabCoordinator?
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
    
    func connectAccounts(){
        let presentor = LoadingAccountsPresentor(budget : self.budget, itemManager: ItemManagerService())
        presentor.coordinator = self
        presentor.viewData.viewState = LoadingAccountsViewState.Initial
        self.presentorStack.append(presentor)
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func launchPlaidLink() {
        let presentor = PlaidLinkViewPresentor()
        presentor.coordinator = self
        self.presentorStack.append(presentor)
        let linkVC = presentor.configure()
        linkVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(linkVC, animated: true)
    }
    
    func dismissPlaidLink(sender: PlaidLinkViewPresentor) {
        
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
        })
        
        _ = self.presentorStack.popLast()
        

    }
    
    func plaidLinkSuccess(sender: PlaidLinkViewPresentor) {
        
        self.presentorStack.popLast()
        let loadingAccountsPresentor = self.presentorStack.last! as! LoadingAccountsPresentor
        loadingAccountsPresentor.startLoadingAccounts()
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
            
        })
        
    }
    
    func plaidIsConnected() {
        self.navigationController.popViewController(animated: true)
        self.presentorStack.popLast()
    }
    
    func connectMoreAccounts(){
        launchPlaidLink()
    }
    
    func dismissSettings(){
        
        self.navigationController.dismiss(animated: true)
        self.navigationController = UINavigationController()
        _ = self.presentorStack.popLast()
        self.parent?.dismissSettings()
        
        
    }

}



