//
//  SettingsViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import LinkKit

struct ItemViewData: Hashable{
    var name : String
}

class SettingsViewModel: ObservableObject{
    
    var loadingAccountsPresentor : LoadingAccountsPresentor?
    var budget : Budget?
    
    var dataManager = DataManager()
    @Published var items : [ItemData]?
    var viewData = [ItemViewData]()
    
    init(){
        
        self.budget = try? dataManager.getBudget()
       updateView()
        
    }
    
    func updateView(){
        
        self.viewData = [ItemViewData]()
        self.items = [ItemData]()
        
        do{
            self.items = try dataManager.getItems()
        }
        catch{
            self.items = [ItemData]()
        }
        
        
        
        generateViewData()
        
    }
    
    func generateViewData(){
        
        for item in self.items!{
            
            let name = UserDefaults.standard.value(forKey: PlaidUserDefaultKeys.institutionId.rawValue + item.institutionId!) as! String
            
            self.viewData.append(ItemViewData(name:name))
            
        }
        
    }
    

    
}
