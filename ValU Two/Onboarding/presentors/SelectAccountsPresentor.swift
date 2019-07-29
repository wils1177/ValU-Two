//
//  SelectAccountsPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/23/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit


class SelectAccountsPresentor : NSObject, UITableViewDelegate, CardsPresentor {
    
    var accounts : [Account]
    var coordinator : BudgetCategoriesDelegate?
    var cardsVC : CardViewController?
    var selectedAccounts = [Account]()
    
    init (accounts: [Account]){
        self.accounts = accounts
        super.init()
    }
    
    func configure() -> UIViewController {
        
        self.cardsVC = CardViewController(nibName: "BudgetCategories", bundle: nil)
        self.cardsVC?.presentor = self
        return cardsVC!
    }
    
    func setupTableView(){
        
        self.cardsVC?.tableView?.dataSource = self
        self.cardsVC?.tableView?.delegate = self
        self.cardsVC?.tableView?.register(CategoryTableViewCell.self, forCellReuseIdentifier: "categoryCell")
        self.cardsVC?.tableView?.allowsMultipleSelection = true
        self.cardsVC?.tableView?.allowsMultipleSelectionDuringEditing = true
        
    }
    
    func submit(){
        
        print(self.selectedAccounts)
        
    }
    

}

extension SelectAccountsPresentor : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell" , for: indexPath) as! CategoryTableViewCell
        
        cell.textLabel?.text = accounts[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.selectedAccounts.append(self.accounts[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let account = accounts[indexPath.row]
        self.selectedAccounts.removeAll { $0 == account }
    }
    
    
    
    
    
    
}
