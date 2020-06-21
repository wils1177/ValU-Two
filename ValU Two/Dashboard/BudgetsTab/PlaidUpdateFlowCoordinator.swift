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
    var publicToken : String
    var fixNowService : FixNowService
    var presentorStack = [Presentor]()
    
    init(navigationController : UINavigationController, itemId: String, publicToken : String, fixNowService : FixNowService){
        self.navigationController = navigationController
        self.itemId = itemId
        self.publicToken = publicToken
        self.fixNowService = fixNowService
    }
    
    func start() {
        launchPlaidLink()
    }
    
    func launchPlaidLink() {
        let presentor = PlaidLinkViewPresentor(publicToken: publicToken)
        presentor.coordinator = self
        let vc = presentor.configure()
        
        vc.modalPresentationStyle = .fullScreen
        self.navigationController.present(vc, animated: true, completion: {
            self.fixNowService.state = FixNowLoadingState.start
        })
        self.presentorStack.append(presentor)
    }
    
    
    func dismissPlaidLink(sender: PlaidLinkViewPresentor) {
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
        })
        _ = self.presentorStack.popLast()
    }
    
    func plaidLinkSuccess(sender: PlaidLinkViewPresentor) {
        //TODO
        //set the needs login back to false
        //rejig the fix now service?
        //Actually push the defatul update using the service.
        print("poopy doopy doo")
        self.fixNowService.markItemAsFixed(itemId: self.itemId)
        self.fixNowService.updateRecentlyFixedItem(itemId: self.itemId)
        
        sender.linkViewController?.dismiss(animated: true, completion: {
            print("link dismissed")
        })
        _ = self.presentorStack.popLast()
    }
    
    func plaidIsConnected(){
        
    }
    func connectMoreAccounts(){
        
    }
    
    
    
}
