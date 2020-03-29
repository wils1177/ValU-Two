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
    case NoTransactionsFound
    case NoItemsFound
    case DuplicateTransaction
}

class DataManager {
    
    let context : NSManagedObjectContext
    
    init () {
        
        self.context = AppDelegate.viewContext
        
    }
    
    func createNewBudget() -> Budget {
        let newBudget = Budget(context: self.context)
        saveDatabase()
        return newBudget
    }
    
    func createNewSpendingCategory(categoryEntry: CategoryEntry) -> SpendingCategory {
        
        let newSpendingCategory = SpendingCategory(categoryEntry: categoryEntry, context: context)
        return newSpendingCategory
    }
    
    func createNewSpendingCategory() -> SpendingCategory {
        
        let newSpendingCategory = SpendingCategory(context: context)
        return newSpendingCategory
    }
    
    func saveAccount(account : AccountJSON, itemId: String){
        
        AccountData(account: account, itemId: itemId, context: self.context)
        
    }
    
    func saveTransaction(transaction: TransactionJSON, itemId: String) -> Transaction{
        print(transaction.name)
        print(transaction.date)
        let transaction = Transaction(transaction: transaction, itemId: itemId, context: self.context)
        self.saveDatabase()
        return transaction

    
    }
    
    func saveItem(item: ItemJSON){
        print("creating a brand new item")
        ItemData(item: item, context: self.context)

    }
    
    func saveIncome(income: IncomeJSON){
        IncomeData(income: income, incomeStreams: income.incomeStreams, context: context)
    }
    
    func saveTransactionRule(name: String, amountOverride: Float, categoryOverride: [String]) -> TransactionRule{
        return TransactionRule(name: name, amountOverride: amountOverride, categoryOverride: categoryOverride, context: self.context)
        
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
        request.shouldRefreshRefetchedObjects = true
        
        do {
            let result = try context.fetch(request) as! [Budget]
            if result.count == 1{
                return result[0]
            }
            else{
                print("too many active budgets!!!")
                return nil
            }
            
            
        } catch {
            
            print("Failed to fetch budget")
            throw DataManagerErrors.NoBudgetFound
            
            
        }
        
        
    }
    
    func getBudgets(predicate: NSPredicate) throws -> [Budget]{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Budget")
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request) as! [Budget]
            return result
            
        } catch {
            
            print("Failed to fetch budget")
            throw DataManagerErrors.NoBudgetFound
            
            
        }
        
        
    }
    
    func getTransactions(startDate: Date, endDate: Date) throws -> [Transaction]{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Transaction")
        request.predicate = NSPredicate(format: "(date > %@) AND (date <= %@)", startDate as NSDate, endDate as NSDate)
        
        do{
            let result = try context.fetch(request) as! [Transaction]
            return result
        }
        catch{
           print("Failed to fetch transactions")
            throw DataManagerErrors.NoTransactionsFound
        }
        
    }
    
    func getTransactions(predicate: NSPredicate) throws -> [Transaction]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Transaction")
        request.predicate = predicate
        do{
            let result = try context.fetch(request) as! [Transaction]
            return result
        }
        catch{
           print("Failed to fetch transactions")
            throw DataManagerErrors.NoTransactionsFound
        }
    }
    

    
    

    
    func fetchMostRecentTransactionDate() throws -> Date{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Transaction")
        request.fetchLimit = 1
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do{
            let result = try context.fetch(request) as! [Transaction]
            return result.first!.date!
        }
        catch{
           print("Failed to fetch transactions")
            throw DataManagerErrors.NoTransactionsFound
        }
        
    }
    
    func getItems() throws -> [ItemData]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemData")
        
        do{
            let result = try context.fetch(request) as! [ItemData]
            return result
        }
        catch{
           print("Failed to fetch Items")
            throw DataManagerErrors.NoItemsFound
        }
    }
    
    func getTransactionRules(name: String) throws -> TransactionRule?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TransactionRule")
        request.predicate = NSPredicate(format: "name == %@", name)

        do{
            let result = try context.fetch(request) as! [TransactionRule]
            if result.count == 1{
                return result[0]
            }
            else{
                return nil
            }
        }
        catch{
           print("Failed to fetch Transaction Rules")
            throw DataManagerErrors.NoItemsFound
        }
    }
    
    func getTransactionRules() throws -> [TransactionRule]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TransactionRule")

        do{
            let result = try context.fetch(request) as! [TransactionRule]
            return result
        }
        catch{
           print("Failed to fetch Transaction Rules")
            throw DataManagerErrors.NoItemsFound
        }
    }
    
    func getIncomeData() throws -> [IncomeData]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "IncomeData")
        
        do{
            let result = try context.fetch(request) as! [IncomeData]
            return result
        }
        catch{
           print("Failed to fetch Income Data")
            throw DataManagerErrors.NoItemsFound
        }
    }
    
    func deleteIncomeData() throws{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "IncomeData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            _ = try context.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
            print("Could not delete the income data")
        }
    }
    
    func deleteEntity(predicate: NSPredicate, entityName: String) throws{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        deleteRequest.resultType = NSBatchDeleteRequestResultType.resultTypeObjectIDs
        
        do {
            let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
            let objectIDArray = result?.result as? [NSManagedObjectID]
            let changes = [NSDeletedObjectsKey : objectIDArray]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes as [AnyHashable : Any], into: [context])
        } catch let error as NSError {
            // TODO: handle the error
            print("Could not delete the Entity:")
            print(entityName)
        }
    }
    
    func saveDatabase(){
        
        // Save the CoreData database
        do{
            try self.context.save()
            print("successfully saved to database")
        }
        catch{
            print("ERROR: could not save to database")
        }
        
    }
    
    func refresh(object: NSManagedObject){
        self.context.refresh(object, mergeChanges: true)
    }
    
    //func discardChanges(){
    //    self.context.undo()
    //}
    
}
