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

class PlaidLinkViewPresentor : UIViewController, Presentor  {
    
    var coordinator : PlaidLinkDelegate?
    var linkViewController: PLKPlaidLinkViewController?
    var publicToken : String?
    var presentorStack = [Presentor]()
    
    init(publicToken : String? = nil){
        self.publicToken = publicToken
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func configure() -> UIViewController {
        // With shared configuration from Info.plist
        let linkViewDelegate = self
        
        if self.publicToken == nil{
            self.linkViewController = PLKPlaidLinkViewController(delegate:
            linkViewDelegate)
        }
        else{
            self.linkViewController = PLKPlaidLinkViewController(publicToken: self.publicToken!, delegate: linkViewDelegate)
        }
        
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            self.linkViewController!.modalPresentationStyle = .formSheet;
        }
        
        return self.linkViewController!
    }
    

    

}

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
