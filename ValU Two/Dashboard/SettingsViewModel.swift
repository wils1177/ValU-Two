//
//  SettingsViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class SettingsViewModel{
    
    var dataManager = DataManager()
    var items : [ItemData]?
    
    init(){
        
        do{
            self.items = try dataManager.getItems()
        }
        catch{
            self.items = [ItemData]()
        }
        
    }
    
}
