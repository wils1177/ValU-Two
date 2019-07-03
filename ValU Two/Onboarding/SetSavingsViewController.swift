//
//  SetSavingsViewController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/23/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit

class SetSavingsViewController: UIViewController {   

    // UX Elements
    @IBOutlet var savingsTotalLabel: UILabel!
    @IBOutlet var incomeAmountLabel: UILabel!
    @IBOutlet var savingsSlider: UISlider!
    @IBOutlet var callToActionButton: UIButton!
    
    // Member Variables
    var viewData : SetSavingsViewData
    var delagate: SetSavingsPresentor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpView()
    }
    
    init(viewData : SetSavingsViewData){
        
        self.viewData = viewData
        super.init(nibName: nil, bundle: nil)
    }
    
    func setUpView(){
        savingsTotalLabel.text = viewData.savingsTotal
        incomeAmountLabel.text = viewData.incomeAmount
        savingsSlider.value = viewData.savingsPercent
        callToActionButton.titleLabel?.text = viewData.callToAction
        
    }
    
    
    @IBAction func selectedCallToAction(_ sender: Any) {
        print("submit savings total")
        self.delagate?.updateBudget()
    }
    
    @IBAction func sliderMoved(_ sender: Any) {
        self.delagate?.sliderMoved(sliderVal: self.savingsSlider.value)
    }
    
    
    required init?(coder aDecoder: NSCoder) { fatalError("die") }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
