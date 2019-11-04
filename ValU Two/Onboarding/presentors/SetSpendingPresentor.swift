//
//  SetSpendingPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 9/6/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit

class SetSpendingPresentor : NSObject, UITableViewDelegate, Presentor, CardsPresentor {
    
    
    
    let spendingCategories : NSOrderedSet
    var coordinator : OnboardingFlowCoordinator?
    var vc : SetSpendingLimitViewController?
    
    init(spendingCategories : NSOrderedSet){
        
        self.spendingCategories = spendingCategories
    }
    
    func configure() -> UIViewController {
        
        self.vc = SetSpendingLimitViewController(nibName: "SetSpendingLimits", bundle: nil)
        self.vc!.presentor = self
        return self.vc!
    }
    
    func setupTableView(){
        
        self.vc!.tableView!.dataSource = self
        self.vc!.tableView!.delegate = self
        self.vc!.tableView!.register(UINib(nibName: "SpendingLimitCell", bundle: nil), forCellReuseIdentifier: "spendingLimitCell")
        
    }
    
    func submit() {
        self.coordinator?.finishedSettingLimits()
    }
    
    @objc func textFieldDidChange(field: UITextField){
        
        
        let amount = field.text
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: amount!)) && (amount! != "") {
            print("amount field did change")
            let newLimit = Float(amount!)
            let categoryIndex = field.tag
            updateSpendingLimit(newLimit: newLimit!, categoryIndex: categoryIndex)
        }

        
    }
    
    func updateSpendingLimit(newLimit : Float, categoryIndex: Int){
        
        let spendingCategory = self.spendingCategories[categoryIndex] as! SpendingCategory
        spendingCategory.limit = newLimit
        
    }
    
    
    
}

extension SetSpendingPresentor : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.spendingCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spendingLimitCell" , for: indexPath) as! SetSpendingLimitCell
        let spendingCategory = self.spendingCategories[indexPath.row] as! SpendingCategory
        cell.categoryNameLabel.text = spendingCategory.category?.name
        
        // Add a function that will be called everytime that the user updates the amount text field
        cell.amountTextFeild.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        cell.amountTextFeild.tag = indexPath.row
        
        //cell.delegate = self
        
        return cell
    }
    

}
