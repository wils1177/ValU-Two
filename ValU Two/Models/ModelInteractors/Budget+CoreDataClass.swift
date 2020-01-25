//
//  Budget+CoreDataClass.swift
//  
//
//  Created by Clayton Wilson on 9/7/19.
//
//

import Foundation
import CoreData

enum TimeFrame: Int32 {
    case monthly
    case semiMonthly
}

@objc(Budget)
public class Budget: NSManagedObject {
    
    
    convenience init(context: NSManagedObjectContext){
        
        print("creating budget")
        let entity = NSEntityDescription.entity(forEntityName: "Budget", in: context)
        self.init(entity: entity!, insertInto: context)
        self.active = true
        self.spent = 0.0
        setTimeFrame(timeFrame: TimeFrame.monthly)
        self.generateSpendingCategories()
        
    }
    
    func generateSpendingCategories(){
        
        let categoryData = CategoriesData()
        let categoryList = categoryData.getCategoriesList()
        
        //Create a spending category for ALL categoryies
        createSpendingCategory(categories: categoryList.categories)
        
    }
    
    func getSubSpendingCategories() -> [SpendingCategory]{
        
        var categoriesToReturn = [SpendingCategory]()
        
        for case let category as SpendingCategory in self.spendingCategories!{
            
            if category.subSpendingCategories != nil{
                for case let subCategory as SpendingCategory in category.subSpendingCategories!{
                    categoriesToReturn.append(subCategory)
                }
            }
            
        }
        
        return categoriesToReturn
    }
    
    func getAllSpendingCategories() -> [SpendingCategory]{
        
        var categoriesToReturn = [SpendingCategory]()
        
        for case let category as SpendingCategory in self.spendingCategories!{
            
            categoriesToReturn.append(category)
            
            if category.subSpendingCategories != nil{
                for case let subCategory as SpendingCategory in category.subSpendingCategories!{
                    categoriesToReturn.append(subCategory)
                }
            }
            
        }
        
        return categoriesToReturn
        
    }
    
    func createSpendingCategory(categories: [CategoryEntry]){
        
        for category in categories{
            
            let newSpendingCategory = DataManager().createNewSpendingCategory(categoryEntry: category)
            self.addToSpendingCategories(newSpendingCategory)
            
            if category.subCategories != nil{
                for subCategory in category.subCategories!{
                    let newSpendingSubCategory = DataManager().createNewSpendingCategory(categoryEntry: subCategory)
                    newSpendingCategory.addToSubSpendingCategories(newSpendingSubCategory)
                }
            }
            
        }
        
    }
        
    
    func calculateSavingsAmount(percentageOfAmount: Float) -> Float{
        var calculation = percentageOfAmount * self.amount
        calculation = (calculation*100).rounded()/100
        return calculation
    }
    
    
    func setTimeFrame(timeFrame: TimeFrame) {
        
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: Date())
        let startOfMonth = Calendar.current.date(from: comp)
        
        if timeFrame == TimeFrame.monthly{
            self.timeFrame = TimeFrame.monthly.rawValue
            self.startDate = startOfMonth
            self.endDate = Calendar.current.date(byAdding: .month, value: 1, to: startOfMonth!)
        }
        else if timeFrame == TimeFrame.semiMonthly{
            //Todo: A real implementation around semi monthly
            print("Semi Monthly does not really work yet")
            self.timeFrame = TimeFrame.semiMonthly.rawValue
            self.startDate = Date()
            self.endDate = Calendar.current.date(byAdding: .day, value: 15, to: Date())
        }
        
        
    }
    
    func getAmountAvailable() -> Float {
        return self.amount * (1 - self.savingsPercent)
    }
    
    
    

}
