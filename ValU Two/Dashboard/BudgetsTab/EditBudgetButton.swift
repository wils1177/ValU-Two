//
//  EditBudgetButton.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditBudgetButton: View {
    
    var budget: Budget
    var coordinator : EditBudgetDelegate
    
    var body: some View {
        Button(action: {
            self.coordinator.showEdit(budgetToEdit: self.budget)
            
        }){
        ZStack{
            
            Text("Edit").foregroundColor(Color(.blue))
        }
        }.buttonStyle(PlainButtonStyle())
    }
}
