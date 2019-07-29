//
//  PlaidViewController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/20/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit

class PlaidViewController: UIViewController {
    
    var coordinator : OnboardingFlowCoordinator?
    
    //UX Elements
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var callToActionButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func pressedCallToAction(_ sender: Any) {
        
        coordinator?.launchPlaidLink()
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
