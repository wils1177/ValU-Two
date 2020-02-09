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
    
    func configure() -> UIViewController {
        // With shared configuration from Info.plist
        let linkViewDelegate = self
        self.linkViewController = PLKPlaidLinkViewController(delegate:
            linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            self.linkViewController!.modalPresentationStyle = .formSheet;
        }
        
        return self.linkViewController!
    }
    
    func dissmisPlaidLink(){
        
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
        linkViewController.dismiss(animated: true, completion: nil)
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
