//
//  PlaidLinkPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/28/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import LinkKit

class PlaidLinkViewPresentor  {
    
    

    var coordinator : PlaidLinkDelegate?
    var linkToken: String?
    var publicToken : String?
    var handler : Handler?
    
    var viewController : UIViewController
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Takes the viewcontroller you want to present link over.
    init(viewControllerToPresentOver: UIViewController){
        self.viewController = viewControllerToPresentOver
    }
    
    func getLinkToken(itemId: String? = nil){
        let tokenService = PlaidLinkTokenService(completion: handleLinkTokenResult(result:))
        tokenService.getLinkToken(itemId: itemId)
    }
    
    func handleLinkTokenResult(result: Result<PlaidLinkTokenResult, Error>){
        switch result {
        case .failure(let error):
            //TODO handle error
            self.linkToken = nil
            print(error)
        case .success(let result):
            print("Gathered Link Token")
            self.linkToken = result.linkToken
            self.openLink()
        }
    }
    
    
    func openLink(){
        
        var linkConfiguration = LinkTokenConfiguration(token: self.linkToken!, onSuccess: linkSuccess(linkSuccess:))
        linkConfiguration.onExit = self.linkExit(exit:)
        
        
        let result = Plaid.create(linkConfiguration)
        switch result{
        case .failure(let error):
             print("Unable to create Plaid handler due to: \(error)")
        case .success(let handler):
             self.handler = handler
        }
        
        let method: PresentationMethod = PresentationMethod.viewController(self.viewController)
        handler!.open(presentUsing: method)
        
        
    }
    
    func setupLink(itemId: String? = nil){
        
        getLinkToken(itemId: itemId)
        
    }
    
    
    func linkSuccess(linkSuccess: LinkSuccess){
        
        print("success In Link Modal")
        
        let institution = linkSuccess.metadata.institution
        let name = institution.name
        let institutionId = institution.id
        PlaidProccessor.savePublicToken(publicToken: linkSuccess.publicToken, institutionName: name, institutionId : institutionId)
        self.coordinator?.plaidLinkSuccess(sender : self)
        
        
    }
    
    func linkExit(exit: LinkExit){
        self.coordinator?.dismissPlaidLink(sender: self)
        print("User exited the link modal!")
    }
    
    
    
    

}
