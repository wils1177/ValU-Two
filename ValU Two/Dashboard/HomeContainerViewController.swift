//
//  HomeContainerViewController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/9/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit

class HomeContainerViewController: UIViewController {
    
    
    @IBOutlet var childView: UIView!
    
    
    // Member Variables
    private var vc : UIViewController?
    
    
    init(vc : UIViewController){
        super.init(nibName: "HomeContainerViewController", bundle: nil)
        self.vc = vc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupChildren()
    }
    
    func setupChildren(){
        let child = self.vc!
        addChild(child)
        let newView = child.view!
        newView.translatesAutoresizingMaskIntoConstraints = true
        newView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        newView.frame = view.bounds
        self.childView.addSubview(newView)
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
