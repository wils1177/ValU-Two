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
    var presentorStack = [Presentor]()
    
    var settingsViewModel : SettingsViewModel?

    
    func start(){
        
        let presentor = SettingsViewModel()
        self.settingsViewModel = presentor
        presentor.coordinator = self
        let vc = presentor.configure()
        navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.pushViewController(vc, animated: false)
        self.navigationController.modalPresentationStyle = .pageSheet
        
        self.presentorStack.append(presentor)
        
    }
    
    func connectAccounts(){
        let presentor = LoadingAccountsPresentor(itemManager: ItemManagerService())
        presentor.coordinator = self
        presentor.viewData.viewState = LoadingAccountsViewState.Initial
        self.presentorStack.append(presentor)
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func launchPlaidLink() {
        /*
        let presentor = PlaidLinkViewPresentor()
        presentor.coordinator = self
        self.presentorStack.append(presentor)
        let linkVC = presentor.configure()
        linkVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(linkVC, animated: true)
         */
    }
    
    func dismissPlaidLink(sender: PlaidLinkViewPresentor) {
        /*
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
        })
        
        _ = self.presentorStack.popLast()
        */

    }
    
    func plaidLinkSuccess(sender: PlaidLinkViewPresentor) {
        
        /*
        self.presentorStack.popLast()
        let loadingAccountsPresentor = self.presentorStack.last! as! LoadingAccountsPresentor
        loadingAccountsPresentor.startLoadingAccounts()
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
            
        })
         */
        
    }
    
    func plaidIsConnected() {
        self.navigationController.popViewController(animated: true)
        self.presentorStack.popLast()
        self.settingsViewModel?.updateView()
        self.settingsViewModel?.objectWillChange.send()
        
    }
    
    func connectMoreAccounts(){
        launchPlaidLink()
    }
    
    
    func showTransactionRuleDetail(rule: TransactionRule){
        let model = TransactionRuleViewModel(rule: rule)
        model.coordinator = self
        let vc = UIHostingController(rootView: TransactionRuleDetailView(viewModel: model))
        vc.title = "New Rule"
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    func dismissSettings(){
        
        self.navigationController.dismiss(animated: true)
        self.navigationController = UINavigationController()
        _ = self.presentorStack.popLast()
        self.parent?.dismissSettings()
        
        
    }
    
    func dismissTransactionDetail(){
        self.navigationController.popViewController(animated: true)
        self.settingsViewModel?.getTransactionRules()
        self.settingsViewModel?.objectWillChange.send()
        
    }
    
    func newTransactionRule(){
        let model = TransactionRuleViewModel()
        model.coordinator = self
        let vc = UIHostingController(rootView: TransactionRuleDetailView(viewModel: model))
        self.navigationController.pushViewController(vc, animated: true)
    }

}



