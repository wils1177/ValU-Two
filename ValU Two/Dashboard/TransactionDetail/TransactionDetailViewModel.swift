//
//  TransactionDetailViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import MapKit
import SwiftUI



class TransactionDetailViewModel: ObservableObject, Presentor, KeyboardDelegate {
    
    
    
    @Published var transaction : Transaction
    
    @Published var isHidden : Bool{
        didSet {
            // Here's where any code goes that needs to run when a switch is toggled
            self.toggleHidden()
        }
    }
    
    
    var coordinator : TransactionRowDelegate?
    
    var account : AccountData?
    
    var service: TransactionService
    
    var budget: Budget?
    
    init(transaction: Transaction, service: TransactionService, budget: Budget? = nil){
        self.transaction = transaction
        self.isHidden = transaction.isHidden
        self.service = service
        self.account = getAccount()
        self.budget = budget
        
    }
    
    
    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: TransactionDetailView(viewModel: self, transaction: self.transaction, account: self.account))
        vc.navigationItem.largeTitleDisplayMode = .never
        return vc
    }
    
    func getAccount() -> AccountData?{
        let accountId = self.transaction.accountId!
        let query = PredicateBuilder().generateByAccountIdPredicate(id: accountId)
        var accountToReturn : AccountData?
        do{
            let account = try DataManager().getEntity(predicate: query, entityName: "AccountData") as! [AccountData]
            if account.first != nil{
                accountToReturn = account.first!
                
            }
        }
        catch{
            print("no account found for transaction detail")
        }
        
        return accountToReturn
    }
    

    
    
    func getIcons(categories: [CategoryMatch]) -> [String]{
        
        var icons = [String]()
        if categories.count == 0{
            icons.append("❓")
            return icons
        }
        for match in categories{
            if match.spendingCategory!.subSpendingCategories!.count == 0{
                icons.append(match.spendingCategory!.icon!)
            }
        }
        
        return icons
        
    }
    
    
    func onKeyBoardSet(text: String, key: String?) {
        
        if let value = text.floatValue{
            if let uuid = key{
                updateCategoryMatchAmount(amount: value, categoryIdString: uuid)
            }
        }
        DataManager().saveDatabase()
    }
    
    func updateCategoryMatchAmount(amount: Float, categoryIdString: String){
        
        for categoryMatch in self.transaction.categoryMatches?.allObjects as! [CategoryMatch]{
            if categoryMatch.id!.uuidString == categoryIdString{
                categoryMatch.amount = amount
                //categoryMatch.spendingCategory!.reCalculateAmountSpent()
                categoryMatch.spendingCategory!.objectWillChange.send()
                self.transaction.objectWillChange.send()
            }
        }
        
    }
    
    func toggleHidden(){
        self.transaction.isHidden.toggle()
        DataManager().saveDatabase()
        self.budget?.objectWillChange.send()
    }
    
    func getLabelViewData(category: SpendingCategory) -> TransactionBudgetLabelViewData?{
        
        self.service.getBudgetLabels(transaction: self.transaction)
        
        let budgetCategories = category.budgetCategory?.allObjects as! [BudgetCategory]
        
        for budgetCategory in budgetCategories{
            if budgetCategory.budgetSection!.budget!.active{
                let name = budgetCategory.budgetSection!.name!
                let icon = budgetCategory.budgetSection!.icon!
                let color = colorMap[Int(budgetCategory.budgetSection!.colorCode)]
                
                let entry = TransactionBudgetLabelViewData(name: name, icon: icon, color: color)
                return entry
            }
        }
        
        return nil
        
    }
    
    
    
}

extension String {
     struct NumFormatter {
         static let instance = NumberFormatter()
     }

     var doubleValue: Double? {
         return NumFormatter.instance.number(from: self)?.doubleValue
     }

     var integerValue: Int? {
         return NumFormatter.instance.number(from: self)?.intValue
     }
    
    var floatValue: Float? {
        return NumFormatter.instance.number(from: self)?.floatValue
    }
}
