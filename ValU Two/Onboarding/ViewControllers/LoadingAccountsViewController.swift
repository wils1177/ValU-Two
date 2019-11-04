//
//  LoadingAccountsViewController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/28/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit

class LoadingAccountsViewController: UIViewController {
    
    @IBOutlet var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet var loadingLabel: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    
    //Member Variables
    var presentor : LoadingAccountsPresentor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func enterLoadingState(){
        self.loadingSpinner.startAnimating()
        self.continueButton.isHidden = true
    }
    
    func enterSuccessState(){
        self.loadingSpinner.isHidden = true
        self.loadingLabel.text = "Success!"
        self.continueButton.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presentor!.viewWillLoad()
    }
    
    @IBAction func pressedContinue(_ sender: Any) {
        
        self.presentor?.userPressedContinue()
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
