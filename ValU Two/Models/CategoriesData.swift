//
//  CategoriesData.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/12/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation

struct CategoryList : Codable {
    let categories : [Category]
    
    enum CodingKeys : String, CodingKey {
        case categories =  "Categories"
    }
    
    func getCategoryByName(name : String) -> Category?{
        
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

struct Category : Codable {
    
    let name : String
    let contains : [String]?
    let subCategories : [Category]?
    
    enum CodingKeys : String, CodingKey {
        case name =  "name"
        case contains = "contains"
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
