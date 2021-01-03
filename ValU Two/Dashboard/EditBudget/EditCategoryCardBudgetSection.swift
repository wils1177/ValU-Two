//
//  EditCategoryCardBudgetSection.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/27/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditCategoryCardBudgetSection<ViewModel>: View where ViewModel: CategoryListViewModel {
    

    var budgetSection : BudgetSection
    var categories : [BudgetCategory]
    
    var viewModel : ViewModel
    

    
    init(section: BudgetSection, viewModel : ViewModel){
        self.budgetSection = section
        self.categories = budgetSection.getBudgetCategories()
        self.viewModel = viewModel
    }
    
    func getDisplayArray(categories: [BudgetCategory]) -> [[BudgetCategory]]{
        return categories.chunked(into: 2)
    }
    
    var title : some View{
        
        HStack(spacing: 0.0){
            
            BudgetSectionIconLarge(color: colorMap[Int(self.budgetSection.colorCode)] as! Color, icon: self.budgetSection.icon!, size: 35).padding(.trailing)
            Text(self.budgetSection.name!).foregroundColor(colorMap[Int(self.budgetSection.colorCode)] as! Color).font(.system(size: 20)).bold()
               Spacer()
               //CategoryButtonView(text: "Add Section")
        }

        
    }
    
    var body: some View {
        VStack(spacing: 0.0){
                 
                 
            self.title
                 
                   
            //Divider().padding(.horizontal)
                
            VStack(spacing: 0){
                ForEach(self.getDisplayArray(categories: self.categories), id: \.self){pair in
                    
                    VStack{
                        GeometryReader{g in
                            HStack{
                                    ForEach(pair, id: \.self){entry in
                                        
                                        HStack{

                                            EditCategoryRowView(category: entry.spendingCategory!, viewModel: self.viewModel).frame(width: (g.size.width / 2))
                                            
                                            if pair.count == 1{
                                                Spacer().frame(width: (g.size.width / 2) + 9)
                                            }
                                        }.padding(.bottom, 15)
                                        
                                        
                                        
                                    }
                                
                                
                            }
                        }
                        
                        
                    }.padding(.vertical, 24)
                    
                        
                }
            }
             
                                       


                 }
    }
}
