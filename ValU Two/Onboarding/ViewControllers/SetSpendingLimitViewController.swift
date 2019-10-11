//
//  SetSpendingLimitViewController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/19/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit

class SetSpendingLimitCell: UITableViewCell {
    
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var amountTextFeild: UITextField!
    
    var delegate : SetSpendingLimitViewController?
    
    
    @IBAction func finishedEditing(_ sender: Any) {
        
        let name = categoryNameLabel.text
        let newLimit = amountTextFeild.text
        delegate?.updateSpendingLimit(name: name!, newLimit: newLimit!)
        
    }
    
    
}

class SetSpendingLimitViewController: UIViewController{
    
    //var budget : Budget
    var presentor : CardsPresentor?
    
    //UX Elements
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView(){
        self.presentor!.setupTableView()
        tableView?.reloadData()
    }
    
    
    @IBAction func pressedCallToAction(_ sender: Any) {
        
        //coordinator?.finishedSettingLimits()
        
    }
    
    func updateSpendingLimit(name: String, newLimit: String){
        
        
        
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
