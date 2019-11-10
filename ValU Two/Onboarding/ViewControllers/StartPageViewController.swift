//
//  ViewController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/5/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit



class StartPageViewController: UIViewController {
    
    //UX Elements
    
    @IBOutlet var continueButton: UIButton!
    
    // Member Variables
    var coordinator: StartPageViewDelegate?
    
    
    init(){
        super.init(nibName: "StartPageViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedContinue(_ sender: Any) {
        coordinator?.continueToOnboarding()
    }
    
    
    
    
    


}

