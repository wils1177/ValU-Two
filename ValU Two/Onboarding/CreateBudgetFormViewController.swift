//
//  CreateBudgetFormViewController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/20/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit

class CreateBudgetFormViewController: UIViewController {
    
    //UX Elements
    @IBOutlet var timeFrameSegementControl: UISegmentedControl!
    @IBOutlet var incomeAmountLabel: UITextField!
    @IBOutlet var requiredLabel: UILabel!
    @IBOutlet var submitButton: UIButton!
    
    //Member Variables
    var timeFrameIndex: Int
    var incomeAmountText: String
    var callToActionMessage: String
    var delegate: CreateBudgetVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    init(viewData : CreateBudgetFormViewRep){
        self.timeFrameIndex = viewData.timeFrameIndex
        self.incomeAmountText = viewData.incomeAmountText
        self.callToActionMessage = viewData.callToActionMessage
        super.init(nibName: nil, bundle: nil)
    }
    
    func setupView(){
        setState()
    }
    
    func setState(){
        self.timeFrameSegementControl.selectedSegmentIndex = self.timeFrameIndex
        self.incomeAmountLabel.text = self.incomeAmountText
        self.submitButton.setTitle(self.callToActionMessage, for: .normal)
        enterNoErrorState()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("die") }
    
    func enterNoErrorState(){
        self.requiredLabel.isHidden = true
    }
    
    func enterErrorState(){
        self.requiredLabel.isHidden = false
    }
    
    @IBAction func selectedCallToAction(_ sender: Any) {
        
        let viewData = CreateBudgetFormViewRep(timeFrameIndex: self.timeFrameSegementControl.selectedSegmentIndex, incomeAmountText: self.incomeAmountLabel.text!, callToActionMessage: self.callToActionMessage)
        self.delegate?.userSelectedCTA(viewData: viewData)
        
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
