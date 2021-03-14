//
//  OnboardingFlowCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


struct OnboardingDependencies {
    var itemManager = ItemManagerService()
    var onboardingSummaryPresentor : OnboardingSummaryPresentor?
}


class OnboardingFlowCoordinator : Coordinator, StartPageViewDelegate, PlaidLinkDelegate{
    

    // Dependencies
    var budget : Budget?
    var onboardingDependencies = OnboardingDependencies()
    
    var childCoordinators = [Coordinator]()
    weak var parent: AppCoordinator?
    var navigationController : UINavigationController
    
    var presentorStack = [Presentor]()
    
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController

    }
    
    func start(){
        
        
        
        print("onboarding flow started")
        
        
        self.navigationController.navigationBar.prefersLargeTitles = true
        

        
        var view = WelcomeView()
        view.coordinator = self
        let vc = UIHostingController(rootView: view)
        vc.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: false)
        
        
    }
    
    func continueToOnboarding() {
        print("Contionue to onboarding")
        
        
        //showSummary()
        continueToPlaid()
        

    }
    


    
    func successfulAccountsLoaded(){
        UserDefaults.standard.set(true, forKey: "UserOnboarded")
    }
    
    func continueToPlaid(){
        
        self.presentorStack = [Presentor]()
        let presentor = LoadingAccountsPresentor(itemManager: self.onboardingDependencies.itemManager)
        presentor.coordinator = self
        presentor.viewData.viewState = LoadingAccountsViewState.Initial
        self.presentorStack.append(presentor)
        let vc = presentor.configure()
        
        self.navigationController.pushViewController(vc, animated: true)
    }
    

    func launchPlaidLink(){
        let presentor = PlaidLinkViewPresentor()
        presentor.coordinator = self
        self.presentorStack.append(presentor)
        let linkVC = presentor.configure()
        linkVC.modalPresentationStyle = .fullScreen
        self.navigationController.present(linkVC, animated: true)
        
    }
    
    func plaidLinkSuccess(sender: PlaidLinkViewPresentor){
        
        print("Plaid LInk SUccess Triggered in Coordiantor")
        self.presentorStack.popLast()
        let loadingAccountsPresentor = self.presentorStack.first! as! LoadingAccountsPresentor
        loadingAccountsPresentor.startLoadingAccounts()
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
            
        })
    }
    
    func plaidIsConnected(){
        //self.onboardingDependencies.onboardingSummaryPresentor?.generateViewData()
        //self.navigationController.popViewController(animated: true)
        //self.presentorStack.popLast()
        continueToOnboardingConfirmation()
        
    }
    
    
    func connectMoreAccounts(){
        self.onboardingDependencies.onboardingSummaryPresentor?.generateViewData()
        launchPlaidLink()
    }
    
    func continueToOnboardingConfirmation(){
        //let vc = UIHostingController(rootView: OnboardingConfirmationView(coordinator: self))
        //self.navigationController.pushViewController(vc, animated: true)
        onboardingComplete()
    }
    
    func onboardingComplete(){
        
        print("onboarding finished")
        
        self.parent!.currentBudget = self.budget
        self.parent!.onboardingComplete(self)
        

        
        self.navigationController.dismiss(animated: true)
        

    }
    
    func dismissPlaidLink(sender: PlaidLinkViewPresentor) {
        
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
        })

    }
    
    

    
    
}


