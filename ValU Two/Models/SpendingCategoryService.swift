//
//  SpendingCategoryService.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/21/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class SpendingCategoryService{
    
    var spendingCategories = [SpendingCategory]()
    
    init(){
        loadCategories()
    }
    
    func loadCategories(){
        do{
            let cats = try DataManager().getEntity(entityName: "SpendingCategory") as! [SpendingCategory]
            
            self.spendingCategories = cats
        }
        catch{
            print("COULD NOT LOAD SPENDING CATEGORIES!!!")
            self.spendingCategories = [SpendingCategory]()
        }

    }
    
    func getSubSpendingCategories() -> [SpendingCategory]{
        
        var categoriesToReturn = [SpendingCategory]()
        
        for case let category as SpendingCategory in self.spendingCategories{
            
            if category.subSpendingCategories != nil{
                for case let subCategory as SpendingCategory in category.subSpendingCategories!{
                    categoriesToReturn.append(subCategory)
                }
            }
            
        }
        
        return categoriesToReturn.filter {$0.hidden != true}
    }
    
    func getParentSpendingCategories() -> [SpendingCategory]{
        
        var categoriesToReturn = [SpendingCategory]()
        
        for case let category as SpendingCategory in self.spendingCategories{
            
            if category.subSpendingCategories != nil && category.subSpendingCategories!.count > 0{
                categoriesToReturn.append(category)
            }
            
        }
        
        return categoriesToReturn
        
    }
    
    func getAllSpendingCategories() -> [SpendingCategory]{
        
        var categoriesToReturn = [SpendingCategory]()
        
        for case let category as SpendingCategory in self.spendingCategories{
            
            categoriesToReturn.append(category)
            
            if category.subSpendingCategories != nil{
                for case let subCategory as SpendingCategory in category.subSpendingCategories!{
                    categoriesToReturn.append(subCategory)
                }
            }
            
        }
        
        return categoriesToReturn.filter {$0.hidden != true}
        
    }
    
    
    static func generateSpendingCategories(){
        
        let categoryData = CategoriesData()
        let categoryList = categoryData.getCategoriesList()
        
        //Create a spending category for ALL categoryies
        createSpendingCategory(categories: categoryList.categories)
        DataManager().saveDatabase()
        
    }
    
    static func createSpendingCategory(categories: [CategoryEntry]){
        
        for category in categories{
            
            let newSpendingCategory = DataManager().createNewSpendingCategory(categoryEntry: category)

            
            if category.subCategories != nil{
                for subCategory in category.subCategories!{
                    let newSpendingSubCategory = DataManager().createNewSpendingCategory(categoryEntry: subCategory)
                    newSpendingCategory.addToSubSpendingCategories(newSpendingSubCategory)
                }
            }
            
        }
        
    }
    
    func createCustomSpendingCategory(icon: String, name: String) -> SpendingCategory{
        let customParent = checkIfCustomParentExists()
        if customParent != nil{
            return saveCustomSpendingCategory(icon: icon, name: name, parent: customParent!)
             
        }
        else{
            let newCustomParent = DataManager().createNewSpendingCategory(icon: "🎩", name: "Custom")
            return saveCustomSpendingCategory(icon: icon, name: name, parent: newCustomParent)
        }
        
    }
    
    func checkIfCustomParentExists() -> SpendingCategory?{
        
        let parentCategories = self.getParentSpendingCategories()
        for parentCategory in parentCategories{
            if parentCategory.name == "Custom"{
                return parentCategory
            }
        }
        
        return nil
        
    }
    
    
    func saveCustomSpendingCategory(icon: String, name: String, parent: SpendingCategory) -> SpendingCategory{
        let manager = DataManager()
        let newCategory = manager.createNewSpendingCategory(icon: icon, name: name)
        parent.addToSubSpendingCategories(newCategory)
        manager.saveDatabase()
        return newCategory
        
    }
    
}
