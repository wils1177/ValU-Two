//
//  PlaidUpdateFlowCoordinator.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit

class PlaidUpdateFlowCoordinator: Coordinator, PlaidLinkDelegate{
    
    
    
    var childCoordinators = [Coordinator]()
    var navigationController : UINavigationController
    var itemId : String
    
    var fixNowService : FixNowService
    var linkPresentor : PlaidLinkViewPresentor
    
    init(navigationController : UINavigationController, itemId: String, fixNowService : FixNowService){
        self.navigationController = navigationController
        self.itemId = itemId
        self.fixNowService = fixNowService
        let link = PlaidLinkViewPresentor(viewControllerToPresentOver: navigationController)
        
        self.linkPresentor = link
    }
    
    func start() {
        self.linkPresentor.coordinator = self
        launchPlaidLink()
    }
    
    func launchPlaidLink() {
        print("it would appear this may not be happening")
        self.linkPresentor.setupLink(itemId: self.itemId)
    }
    
    
    func dismissPlaidLink(sender: PlaidLinkViewPresentor) {
        print("dismiss Plaid Link")
        self.fixNowService.state = FixNowLoadingState.start
    }
    
    func plaidLinkSuccess(sender: PlaidLinkViewPresentor) {
        
        
        print("poopy doopy doo")
        self.fixNowService.markItemAsFixed(itemId: self.itemId)
        self.fixNowService.updateRecentlyFixedItem(itemId: self.itemId)
        
        
        self.linkPresentor.coordinator = nil
        
    }
    
    func plaidIsConnected(){
        
    }
    func connectMoreAccounts(){
        
    }
    
    
    
}
