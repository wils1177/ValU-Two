//
//  Option2Card.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/6/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetSection: View {
    
    var spendingCategory : SpendingCategory
    var title: String
    var children : [SpendingCategory]
    var viewModel : SpendingCardViewModel
    
    init(spendingCategory: SpendingCategory, viewModel: SpendingCardViewModel){
        self.spendingCategory = spendingCategory
        self.viewModel = viewModel
        self.title = spendingCategory.name!
        self.children = spendingCategory.subSpendingCategories?.allObjects as! [SpendingCategory]
    }
    
        var body: some View {
            VStack(spacing: 0.0){
                
                HStack{
                    Text(self.title).font(.headline).foregroundColor(.gray)
                    Spacer()
                }.padding(.bottom, 15)
                
                    ForEach(self.children, id: \.self) { child in
                        VStack(){
                            if child.selected{
                                Button(action: {
                                    self.viewModel.coordinator?.showCategory(categoryName: child.name!)
                                }) {
                                    //BudgetBarView(spendingCategory: child).padding(.bottom, 15)
                                    TempBudgetBar(spendingCategory: child).padding(.bottom, 20)
                                }.buttonStyle(PlainButtonStyle())
                                
                            }
                        
                        }
                }
                
                
                    
                    
        }
                
    }
            
            
}
    


