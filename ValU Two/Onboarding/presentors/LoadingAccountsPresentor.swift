//
//  LoadingAccountsPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/28/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit

class LoadingAccountsPresentor : Presentor {
    
    var viewController : LoadingAccountsViewController?

    
    func configure() -> UIViewController {
        let vc = LoadingAccountsViewController()
        self.viewController = vc
        self.viewController!.presentor = self
        return self.viewController!
    }
    
    func viewWillLoad(){
        viewController?.enterLoadingState()
        pullInAccountData()
    }
    
    func pullInAccountData(){
        let plaid = PlaidConnection()
        
        let dispatchA = DispatchGroup()
        let dispatchB = DispatchGroup()
        
        print("Exchanging public token...")
        try? plaid.exchangePublicForAccessToken(dispatch: dispatchA)
        
        
        dispatchA.notify(queue: .main){
            print("getting transactions...")
            
            try? plaid.getTransactions(dispatch: dispatchB)
            
            dispatchB.notify(queue: .main){
                self.viewController?.enterSuccessState()
            }
    
        }
        
        
    }
    
    
}
