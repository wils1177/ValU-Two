//
//  ContainerViewController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/20/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    //UX Elements
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var continueButton: UIButton!
    
    
    // Member Variables
    private var bottomVC : UIViewController
    private let headerText : String?

    
    
    init(title: String, vc: UIViewController){
        self.headerText = title
        self.bottomVC = vc
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("die") }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpView()
        
    }
    
    func setUpView(){
        self.headerLabel.text = headerText
        temp_setup_children()
    }
    
    func temp_setup_children(){
        let child = self.bottomVC
        addChild(child)
        let newView = child.view!
        newView.translatesAutoresizingMaskIntoConstraints = true
        newView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        newView.frame = view.bounds
        self.bottomView.addSubview(newView)
        
        child.didMove(toParent: self)
        
        
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
