//
//  SwiftUIBudgetView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/13/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingCardView: View {
    
    var viewModel : SpendingCardViewModel
    
    init(budget : Budget, viewModel: SpendingCardViewModel, coordinator: BudgetsTabCoordinator){
        //print("Spending Card init")
        self.viewModel = viewModel
        viewModel.coordinator = coordinator
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

               // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
    }
    
    
    
    
    var body: some View {
            
            
        VStack(spacing: 0.0){
            
            HStack{
                Text("Expenses").font(.system(size: 20)).bold()
                Spacer()
                Text("$" + String(self.viewModel.totalSpending)).font(.headline).fontWeight(.bold)
            }.padding(.bottom, 15)
                
                Divider().padding(.bottom, 5)
                
                
                    ForEach(self.viewModel.categories, id: \.self){ category in
                            
                        
                            
                            VStack(spacing: CGFloat(0.0)){
                                if category.isAnyChildSelected(){

                                    BudgetSection(spendingCategory: category, viewModel: self.viewModel).padding(.top).cornerRadius(10)
                                    
                                }
                                
                                
                                if self.viewModel.categories.last!.name! == category.name!{
                                    
                                        
                                        HStack{
                                            Text(names.otherCategoryName.rawValue).font(.headline).foregroundColor(.gray)
                                            Spacer()
                                        }.padding(.bottom, 15)
                                        
                                        
                                        Button(action: {
                                            self.viewModel.coordinator?.showCategory(categoryName: names.otherCategoryName.rawValue)
                                        }) {
                                            BudgetBarView(iconText: self.viewModel.otherCategory!.icon, categoryName: self.viewModel.otherCategory!.name, amountSpent: self.viewModel.otherCategory!.spent, limitText: self.viewModel.otherCategory!.limit, percentage: Double(self.viewModel.otherCategory!.percentage)).padding(.bottom, 15)
                                        }.buttonStyle(PlainButtonStyle())
                                        
                                        
                                    
                                    
                                }
                                
                            
                        }
                        
                    }
                
                
                
            
            
                }
            
            
            

        
        
    }
}




