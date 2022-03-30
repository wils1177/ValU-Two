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
    
    enum PlaidLinkState {
        case start
        case fetchingLink
        case linkTokenFetched
        case loaded
        case error
    }

    var coordinator : PlaidLinkDelegate?
    var linkToken: String?
    var publicToken : String?
    var handler : Handler?
    var state = PlaidLinkState.start
    
    var viewController : UIViewController
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Takes the viewcontroller you want to present link over.
    init(viewControllerToPresentOver: UIViewController){
        self.state = PlaidLinkState.start
        self.viewController = viewControllerToPresentOver
    }
    
    func getLinkToken(){
        let tokenService = PlaidLinkTokenService(completion: handleLinkTokenResult(result:))
        tokenService.getLinkToken()
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
        
        let linkConfiguration = LinkTokenConfiguration(token: self.linkToken!, onSuccess: linkSuccess(linkSuccess:))
        
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
    
    func setupLink(){
        
        getLinkToken()
        
    }
    
    
    func linkSuccess(linkSuccess: LinkSuccess){
        
        print("success In Link Modal")
        
        let institution = linkSuccess.metadata.institution
        let name = institution.name
        let institutionId = institution.id
        PlaidProccessor.savePublicToken(publicToken: linkSuccess.publicToken, institutionName: name, institutionId : institutionId)
        self.coordinator?.plaidLinkSuccess(sender : self)
        
        
    }
    
    
    

}

/*
extension PlaidLinkViewPresentor : PLKPlaidLinkViewDelegate
{
    func linkViewController(_ linkViewController:
        PLKPlaidLinkViewController, didSucceedWithPublicToken publicToken:
        String, metadata: [String : Any]?) {
        
        print("success In Link Modal")
        
        let institution = metadata!["institution"] as! [String : String]
        let name = institution["name"]
        let institutionId = institution["institution_id"]
        PlaidProccessor.savePublicToken(publicToken: publicToken, institutionName: name!, institutionId : institutionId!)
        self.coordinator?.plaidLinkSuccess(sender : self)
        //linkViewController.dismiss(animated: true, completion: nil)
 
    }
    
    func linkViewController(_ linkViewController:
        PLKPlaidLinkViewController, didExitWithError error: Error?,
                                    metadata: [String : Any]?) {
        dismiss(animated: true) {
            if let error = error {
                print("Exited with error")
            }
            else {
                print("Exited without any error")
            }
        }
        self.coordinator?.dismissPlaidLink(sender: self)
    }
    
    func linkViewController(_ linkViewController:
        PLKPlaidLinkViewController, didHandleEvent event: String, metadata:
        [String : Any]?) {
        print("Link Event!")
        if event == "ERROR"{
            print(metadata)
        }
        
    }
    
}
*/
