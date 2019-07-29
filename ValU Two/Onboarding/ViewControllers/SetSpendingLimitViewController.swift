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

class SetSpendingLimitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var budget : Budget
    var coordinator : SetSpendingLimitDelegate?
    
    //UX Elements
    @IBOutlet var tableView: UITableView!
    
    
    init(budget : Budget){
        
        self.budget = budget
        super.init(nibName: "SetSpendingLimits", bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let nib = UINib(nibName: "SpendingLimitCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "spendingLimitCell")
    }
    
    func setupView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    @IBAction func pressedCallToAction(_ sender: Any) {
        
        coordinator?.finishedSettingLimits()
        
    }
    
    func updateSpendingLimit(name: String, newLimit: String){
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.budget.spendingCategories.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spendingLimitCell" , for: indexPath) as! SetSpendingLimitCell
        let spendingCategories = self.budget.spendingCategories
        cell.categoryNameLabel.text = self.budget.spendingCategories[indexPath.row].category.name
        cell.delegate = self
        
        return cell
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
