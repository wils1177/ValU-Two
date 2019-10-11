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
    var coordinator : Coordinator?
    var vc : SetSpendingLimitViewController?
    
    init(spendingCategories : NSOrderedSet){
        
        self.spendingCategories = spendingCategories
    }
    
    func configure() -> UIViewController {
        
        self.vc = SetSpendingLimitViewController()
        self.vc!.presentor = self
        return self.vc!
    }
    
    func setupTableView(){
        
        self.vc!.tableView!.dataSource = self
        self.vc!.tableView!.delegate = self
        self.vc!.tableView!.register(SetSpendingLimitCell.self, forCellReuseIdentifier: "spendingLimitCell")
        
        
    }
    
    func submit() {
        print("hi")
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
        //cell.delegate = self
        
        return cell
    }
    

}
