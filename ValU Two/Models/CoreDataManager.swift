//
//  CoreDataManager.swift
//  ValU Two
//
//  Created by Clayton Wilson on 9/6/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import CoreData

enum DataManagerErrors: Error {
    case NoBudgetFound
}

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
    
    func getBudget() throws ->  Budget?{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Budget")
        request.predicate = NSPredicate(format: "active == true")
        
        do {
            let result = try context.fetch(request) as! [Budget]
            if result.count == 1{
                return result[0]
            }
            else{
                return nil
            }
            
            
        } catch {
            
            print("Failed to fetch budget")
            throw DataManagerErrors.NoBudgetFound
            
            
        }
        
        
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
