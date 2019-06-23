//
//  SetSpendingCategoriesViewController.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/9/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import UIKit

class spendingCagtegoryCell: UITableViewCell{
    
    
    @IBOutlet var categoryNameTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    
    var delegate: spendingCategoryCellDelegate?
    var index: Int?
    
    @IBAction func userEditedAmountField(_ sender: Any) {
        self.delegate?.finishinedEditingSpendingCategoryCellAmount(index: self.index!, amount: self.amountTextField.text!)
    }
    
    @IBAction func userEditedNameField(_ sender: Any) {
        self.delegate?.finishinedEditingSpendingCategoryCellName(index: self.index!, name: self.categoryNameTextField.text!)
    }
    
    
    
}

protocol spendingCategoryCellDelegate {
    func finishinedEditingSpendingCategoryCellAmount(index: Int, amount: String)
    func finishinedEditingSpendingCategoryCellName(index: Int, name: String)
}

class SetSpendingCategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, spendingCategoryCellDelegate {
    
    //Member Data
    var budget : Budget!
    
    //UX Elements
    @IBOutlet var SpendingCategoryTableView: UITableView!
    @IBOutlet var addNewCategoryButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.SpendingCategoryTableView.delegate = self
        self.SpendingCategoryTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.budget.getSpendingCategories().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spendingCategory", for: indexPath ) as! spendingCagtegoryCell
        let name = self.budget.getSpendingCategories()[indexPath.row].getName()
        
        cell.categoryNameTextField.text = name
        cell.delegate = self
        cell.index = indexPath.row
        
        
        return cell
    }
    
    func finishinedEditingSpendingCategoryCellAmount(index: Int, amount: String){
        
        self.budget.updateSpendingCategoryLimit(index: index, amount: amount)
        print("updated the amount")
        
    }
    
    func finishinedEditingSpendingCategoryCellName(index: Int, name: String){
        
        self.budget.updateSpendingCategoryName(index: index, name: name)
        print("updated the name")
        
    }
    
    @IBAction func addNewCategoryButtonPressed(_ sender: Any) {
        self.budget.addNewSpendingCategory(name: "")
        self.SpendingCategoryTableView.reloadData()
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
