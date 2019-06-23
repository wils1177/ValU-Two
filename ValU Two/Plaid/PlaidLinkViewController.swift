//
//  PlaidLinkViewController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/8/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit
import LinkKit

class PlaidLinkViewController: UIViewController {
    
    var plaidConnection : PlaidConnection?

    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
        
    }
    
    
    func presentLinkController(){
        
        // With shared configuration from Info.plist
        let linkViewDelegate = self
        let linkViewController = PLKPlaidLinkViewController(delegate:
            linkViewDelegate)
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            linkViewController.modalPresentationStyle = .formSheet;
        }
        present(linkViewController, animated: false)
    }
    
    @IBAction func launchPlaidLinkButton(_ sender: Any) {
        
        presentLinkController()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlaidLinkViewController : PLKPlaidLinkViewDelegate
{
    func linkViewController(_ linkViewController:
        PLKPlaidLinkViewController, didSucceedWithPublicToken publicToken:
        String, metadata: [String : Any]?) {
        dismiss(animated: true) {
            // Handle success, e.g. by storing publicToken with your
            print("Success")
            print(publicToken)
            self.plaidConnection  = PlaidConnection(publicKey: publicToken)
            self.plaidConnection?.aggregateAccounts(response: metadata!)
        }
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
