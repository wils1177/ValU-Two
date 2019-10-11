//
//  BudgetCategoriesPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/3/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit

struct BudgetCategoryViewModel {
    let sectionTitle : String
    let categories : [String]
}

class BudgetCardsPresentor : NSObject, UITableViewDelegate, CardsPresentor {
    
    var cardsVC : CardViewController?
    var viewModels : [BudgetCategoryViewModel]?
    var categoryList : CategoryList?
    var selectedCategoryNames = [String]()
    var budget : Budget
    var coordinator : BudgetCategoriesDelegate?
    

    init (budget: Budget){
        self.budget = budget
        super.init()
        viewModels = generateViewModels()
    }

    func configure() -> UIViewController {
        
        self.cardsVC = CardViewController(nibName: "BudgetCategories", bundle: nil)
        self.cardsVC?.presentor = self
        return cardsVC!
    }
    
    func generateViewModels() -> [BudgetCategoryViewModel]{
        
        let categoryData = CategoriesData()
        self.categoryList = categoryData.getCategoriesList()
        var viewModels = [BudgetCategoryViewModel]()
        
        for category in self.categoryList!.categories{
            let sectionTitle = category.name
            var subCategoryTitles = [String]()
            if category.subCategories != nil{
                
                for subCategory in category.subCategories!{
                    subCategoryTitles.append(subCategory.name)
                }
                
            }
            
            viewModels.append(BudgetCategoryViewModel(sectionTitle: sectionTitle, categories: subCategoryTitles))
            
        }
        
        return viewModels
    }
    
    func setupTableView(){
        
        self.cardsVC?.tableView?.dataSource = self
        self.cardsVC?.tableView?.delegate = self
        self.cardsVC?.tableView?.register(CategoryTableViewCell.self, forCellReuseIdentifier: "categoryCell")
        self.cardsVC?.tableView?.allowsMultipleSelection = true
        self.cardsVC?.tableView?.allowsMultipleSelectionDuringEditing = true
        
    }
    
    func submit(){
        
        var newSpendingCategoriesList = [SpendingCategory]()
        for name in self.selectedCategoryNames{
            let category = self.categoryList?.getCategoryByName(name: name)
            let newSpendingCategory = DataManager().createNewSpendingCategory(categoryEntry: category!)
            newSpendingCategoriesList.append(newSpendingCategory)
        }
                
        for category in newSpendingCategoriesList{
            self.budget.addToSpendingCategories(category)
        }
        
        self.coordinator?.categoriesSubmitted()
        
    }
    
    

}

extension BudgetCardsPresentor : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModels![section].sectionTitle
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels![section].categories.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell" , for: indexPath) as! CategoryTableViewCell
        
        let section = indexPath.section
        cell.textLabel?.text = viewModels![section].categories[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let name = viewModels![section].categories[indexPath.row]
        self.selectedCategoryNames.append(name)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let name = viewModels![section].categories[indexPath.row]
        self.selectedCategoryNames.removeAll { $0 == name }
    }
    
    
    
    
    
    
}

