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
        let dispatch = DispatchGroup()
        plaid.getTransactions(dispatch: dispatch)
        
        dispatch.notify(queue: .main){
            self.viewController?.enterSuccessState()
        }
    }
    
    
}
