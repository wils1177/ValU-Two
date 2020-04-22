//
//  CategoriesData.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/12/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

struct CategoryList : Codable {
    let categories : [CategoryEntry]
    
    enum CodingKeys : String, CodingKey {
        case categories =  "Categories"
    }
    
    func getCategoryByName(name : String) -> CategoryEntry?{
        
        for category in self.categories{
            
            if name == category.name{
                return category
            }
            
            if let checkSubCategories = category.subCategories{
                for subCategory in checkSubCategories{
                    if name == subCategory.name{
                        return subCategory
                    }
                }
            }
        }
        
        return nil
        
    }
    
}


struct CategoryEntry : Codable {
    
    let name : String
    let contains : [String]?
    let icon : String?
    let subCategories : [CategoryEntry]?
    
    enum CodingKeys : String, CodingKey {
        case name =  "name"
        case contains = "contains"
        case icon = "icon"
        case subCategories = "subCategories"
    }
    
}


class CategoriesData {
    
    
    
    func getCategoriesList() -> CategoryList {
        
        var categoriesList : CategoryList?
        let url = Bundle.main.url(forResource: "Categories", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        do {
            categoriesList = try decoder.decode(CategoryList.self, from: data)
        } catch (let err) {
            print(err.localizedDescription)
        }
        
        return categoriesList!
        
    }
    
}


class SpendingCategoryGenerator {
    
    static func setupSpendingCategories(){
        
        let categoryData = CategoriesData()
        let categoryList = categoryData.getCategoriesList()
        
        createSpendingCategory(categories: categoryList.categories)
        
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
    
}
