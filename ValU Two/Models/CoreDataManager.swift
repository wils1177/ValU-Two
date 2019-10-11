//
//  CoreDataManager.swift
//  ValU Two
//
//  Created by Clayton Wilson on 9/6/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    let context : NSManagedObjectContext
    
    init () {
        
        self.context = AppDelegate.viewContext
        
    }
    
    func createNewBudget() -> Budget {
        let newBudget = Budget(context: self.context)
        return newBudget
    }
    
    func createNewSpendingCategory(categoryEntry: CategoryEntry) -> SpendingCategory {
        
        let newSpendingCategory = SpendingCategory(categoryEntry: categoryEntry, context: context)
        return newSpendingCategory
    }
    
    func saveAccount(account : AccountJSON){
        
        AccountData(account: account, context: self.context)
        
    }
    
    func saveTransaction(transaction: TransactionJSON){
        
        Transaction(transaction: transaction, context: self.context)
    
    }
    
    func saveItem(item: ItemJSON){
        
        ItemData(item: item, context: self.context)

    }
    

    
    func getAccounts() -> [AccountData]{
        
        var accountsToReturn = [AccountData]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AccountData")
        
        do {
            let result = try context.fetch(request)
            for account in result as! [AccountData] {
                accountsToReturn.append(account)
            }
            
        } catch {
            
            print("Failed to fetch accounts")
        }
        
        return accountsToReturn
    }
    
    func saveDatabase(){
        
        // Save the CoreData database
        do{
            try self.context.save()
            print("successfully saved to database")
        }
        catch{
            print("could not save new accounts to database")
        }
        
    }
    
}
